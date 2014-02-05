require 'spec_helper'

describe Api::V1::UsersController do

  describe "#password_reset" do

    context "as a user" do
      before(:each) do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      it "returns 403" do
        post :password_reset
        expect(@response.code.to_i).to eql 403
      end

      it "returns an error message" do
        post :password_reset
        json = JSON.parse(@response.body)
        expect(json["errors"].first).to eql Api::V1::UsersController::CANNOT_MANAGE
      end

    end

    context "as an admin" do
      before(:each) do
        @user = FactoryGirl.create(:admin)
        sign_in @user
      end

      it "forbids a user to reset their own password" do
        post :password_reset, user_id: @user.id
        expect(@response.code.to_i).to eql 403
        json = JSON.parse(@response.body)
        expect(json["errors"].first).to eql Api::V1::UsersController::NOT_ALLOWED
      end

      context "with no user in json data" do
        it "returns 404" do
          post :password_reset
          expect(@response.code.to_i).to eql 404
        end

        it "returns an error message" do
          post :password_reset
          json = JSON.parse(@response.body)
          expect(json["errors"].first).to eql Api::V1::UsersController::NOT_FOUND
        end
      end

      context "another user exists" do
        before(:each) do
          @user2 = FactoryGirl.create(:user)
        end

        it "returns 200" do
          post :password_reset, user_id: @user2.id
          expect(@response.code.to_i).to eql 200
        end

        it "returns that users new password" do
          post :password_reset, user_id: @user2.id
          json = JSON.parse(@response.body)
          expect(json["password"].length).to eql Api::V1::UsersController::PASS_LENGTH
        end

      end

    end
  end
end
