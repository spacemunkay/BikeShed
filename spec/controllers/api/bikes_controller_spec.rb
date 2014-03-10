require 'spec_helper'

describe Api::V1::BikesController do
  render_views

  describe "#create" do
    context "as a user" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end
      it "returns 403" do
        post :create
        expect(@response.code.to_i).to eql 403
      end

      it "returns an error message" do
        post :create
        json = JSON.parse(@response.body)
        expect(json["errors"].first).to eql Api::V1::BikesController::CANNOT_MANAGE
      end
    end

    context "as a bike admin" do
      before(:each) do
        @user = FactoryGirl.create(:bike_admin)
        sign_in @user
      end

      context "with no bike in json data" do
        it "returns 400" do
          post :create
          expect(@response.code.to_i).to eql 422
        end

        it "returns an error message" do
          post :create
          json = JSON.parse(@response.body)
          expect(json["errors"].first).to eql Api::V1::BikesController::EXPECTED_BIKE
        end
      end

      context "with valid bike in json data" do
        before(:each) do
          @submit_json = { bikes: [{
            serial_number: "XKCD",
            bike_brand_id: 1,
            shop_id: 1,
            model: "Bike Model",
            bike_style_id: 1,
            seat_tube_height: 52,
            bike_condition_id: 1,
            bike_purpose_id: 1,
            bike_wheel_size_id: 1,
          }]}
        end

        it "returns 200" do
          post :create, @submit_json
          expect(@response.code.to_i).to eql 200
        end

        it "returns the created bike json" do
          post :create, @submit_json
          json = JSON.parse(@response.body)
          expect(json).to have_key("bike")
          expect(json.to_s).to include(@submit_json[:bike][:serial_number])
        end
      end

      context "with invalid bike in json data" do
        before(:each) do
          @submit_json = { bikes: [{
            serial_number: "XKCD",
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

  describe "#show" do
    context "as a user" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      context "no bike exists" do
        it "returns 404" do
          get :show, id: 999
          expect(@response.code.to_i).to eql 404
        end

        it "returns an error message" do
          get :show, id: 999
          json = JSON.parse(@response.body)
          expect(json["errors"].first).to eql Api::V1::BikesController::NOT_FOUND
        end
      end

      context "a bike exists" do
        let!(:bike){ FactoryGirl.create(:bike) }

        it "returns 200" do
          get :show, id: bike.id, format: :json
          expect(@response.code.to_i).to eql 200
        end

        it "returns the bike json" do
          get :show, id: bike.id, format: :json
          json = JSON.parse(@response.body)
          expect(json).to have_key("bikes")
          expect(json.to_s).to include(bike.serial_number)
        end
      end
    end
  end
end
