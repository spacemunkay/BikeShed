require 'spec_helper'

describe Api::V1::TasksController do
  render_views

  describe "#update" do
    context "as a user with a bike" do
      before(:each) do
        @user = FactoryGirl.create(:user_with_bike)
        sign_in @user
      end

      context "with no tasks in json data" do
        it "returns 400" do
          put :update
          expect(@response.code.to_i).to eql 422
        end

        it "returns an error message" do
          put :update
          json = JSON.parse(@response.body)
          expect(json["errors"].first).to eql Api::V1::TasksController::EXPECTED_TASKS
        end
      end

      context "with non existing task in data" do
        before(:each) do
          @submit_json = { tasks: [
            { id: 9999, done: false },
          ]}
        end

        it "returns 404" do
          put :update, @submit_json
          expect(@response.code.to_i).to eql 404
        end

        it "returns an error message" do
          put :update, @submit_json
          json = JSON.parse(@response.body)
          expect(json["errors"].to_s).to include(Api::V1::TasksController::NOT_FOUND)
        end
      end

      context "with valid tasks json data" do
        before(:each) do
          @task = FactoryGirl.create(:task, done: false, task_list_id: @user.bike.task_list.id)
          task_data = { tasks: [
            { id: @task.id, done: true},
          ]}
          #this is necessary because render_views does not work with sign_in devise helper
          @submit_json = api_submit_json(@user, task_data)
          #not sure why format: :json not working
          request.accept = 'application/json'
        end

        it "returns 200" do
          put :update, @submit_json
          expect(@response.code.to_i).to eql 200
        end

        it "returns the updated task json" do
          put :update, @submit_json
          json = JSON.parse(@response.body)
          expect(json).to have_key("tasks")
          expect(json.to_s).to include(Task.find_by_id(@task.id).done.to_s)
        end

        it "updates the task" do
          expect{put :update, @submit_json}.
            to change{ Task.find_by_id(@task.id).done }.
              from(false).to(true)
        end
      end
    end

    context "as a user without a bike" do
      before(:each) do
        @user = FactoryGirl.create(:user, bike_id: nil)
        sign_in @user

        task = FactoryGirl.create(:task)
        @submit_json = { tasks: [
          { id: task.id, done: false },
        ]}
      end

      it "should return 403" do
        put :update, @submit_json
        expect(@response.code.to_i).to eql 403
      end

      it "returns an error message" do
        put :update, @submit_json
        json = JSON.parse(@response.body)
        expect(json["errors"].to_s).to include(Api::V1::TasksController::CANNOT_MANAGE)
      end
    end
  end
end
