require 'spec_helper'

describe Api::V1::TimeEntriesController do
  render_views

  describe "#create" do

    context "as a user" do
      let!(:user){ FactoryGirl.create(:user) }

      before(:each) do
        sign_in user
      end

      context "with no time entry in json data" do
        it "returns error status" do
          post :create
          json = JSON.parse(@response.body)
          expect(@response.code.to_i).to eql 422
        end

        it "returns an error message" do
          post :create
          json = JSON.parse(@response.body)
          expect(json["errors"].first).to eql Api::V1::TimeEntriesController::EXPECTED_TIME_ENTRY
        end
      end

      context "with valid time entry in json data" do

        before(:each) do
          time_data = { time_entries: [{
            start_date: Time.zone.now,
            end_date: Time.zone.now + 60,
            log_action_id: 1,
            bike_id: -1,
            description: "My description"}]
          }

          #this is necessary because render_views does not work with sign_in devise helper
          @submit_json = api_submit_json(user, time_data)
          #not sure why format: :json not working
          request.accept = 'application/json'
        end

        it "returns 200" do
          post :create, @submit_json
          expect(@response.code.to_i).to eql 200
        end

        it "returns the created time entry json" do
          post :create, @submit_json
          json = JSON.parse(@response.body)
          expect(json).to have_key("time_entries")
          expect(json.to_s).to include(@submit_json[:time_entries].first[:description])
        end
      end

      context "with invalid time entry in json data" do
        before(:each) do
          @submit_json = { time_entries: [{
            description: "My description",
          }]}
        end

        it "returns 422" do
          post :create, @submit_json
          expect(@response.code.to_i).to eql 422
        end

        it "returns the fields with errors" do
          post :create, @submit_json
          json = JSON.parse(@response.body)
          expect(json).to have_key("errors")
          expect(json.to_s).to include("can't be blank")
        end
      end
    end
  end
end
