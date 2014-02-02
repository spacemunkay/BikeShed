require 'spec_helper'

describe Api::V1::LogsController do

  describe "#checkin" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      controller.stub(:current_user).and_return(@user)
    end

    context "user is not checked in" do
      before(:each) do
        @user.stub(:checked_in?).and_return(false)
      end

      it "returns 204" do
          @user.stub(:checkin)
          post :checkin
          expect(@response.code.to_i).to eql 204
      end

      it "checks in a user" do
          expect(@user).to receive(:checkin)
          post :checkin
      end
    end

    context "user is already checked in" do
      before(:each) do
        @user.stub(:checked_in?).and_return(true)
      end

      it "returns 404 if the user is already checked in" do
        post :checkin
        expect(@response.code.to_i).to eql 404
      end
    end
  end

  describe "#checkout" do

    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      controller.stub(:current_user).and_return(@user)
    end

    context "user is not checked in" do
      before(:each) do
        @user.stub(:checked_in?).and_return(false)
      end

      it "returns 404" do
          @user.stub(:checkin)
          post :checkout
          expect(@response.code.to_i).to eql 404
      end
    end

    context "user is already checked in" do
      before(:each) do
        @user.stub(:checked_in?).and_return(true)
      end

      it "returns 204" do
          @user.stub(:checkout)
          post :checkout
          expect(@response.code.to_i).to eql 204
      end

      it "checks out a user" do
          expect(@user).to receive(:checkout)
          post :checkout
      end
    end
  end
end
