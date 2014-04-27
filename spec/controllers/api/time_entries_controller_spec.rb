require 'spec_helper'

describe Api::V1::TimeEntriesController do

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
    end
  end
end
