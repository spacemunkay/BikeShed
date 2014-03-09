require 'spec_helper'

describe Api::V1::TaskListsController do
  render_views

  describe "#show" do
    context "as a user" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      context "task list exists" do
        let!(:task_list){ FactoryGirl.create(:task_list) }

        it "returns 200" do
          get :show, id: task_list.id, format: :json
          expect(@response.code.to_i).to eql 200
        end

        it "returns valid task list json" do
          get :show, id: task_list.id, format: :json
          json = JSON.parse(@response.body)
          expect(json.to_s).to include(task_list.name)
        end

        it "returns task list with tasks json" do
          get :show, id: task_list.id, format: :json
          json = JSON.parse(@response.body)
          expect(task_list.tasks.count).to be > 0
          task_list.tasks.each do |task|
            expect(json.to_s).to include(task.task)
          end
        end
      end

      context "task list does not exist" do
        it "returns 404" do
          get :show, id: 999, format: :json
          expect(@response.code.to_i).to eql 404
        end

        it "returns an error message" do
          get :show, id: 999, format: :json
          json = JSON.parse(@response.body)
          expect(json["errors"].first).
            to eql Api::V1::TaskListsController::NOT_FOUND
        end
      end
    end
  end
end
