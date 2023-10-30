require 'rails_helper'

RSpec.describe SessionsHelper, type: :helper do
  let(:user) { FactoryBot.create(:user) }

  describe "#log_in" do
    it "logs in a user" do
      log_in(user)
      expect(session[:user_id]).to eq(user.id)
    end
  end

  describe "#current_user" do
    context "when user is logged in" do
      before { log_in(user) }

      it "returns the logged-in user" do
        expect(current_user).to eq(user)
      end
    end

    context "when no user is logged in" do
      it "returns nil" do
        expect(current_user).to be_nil
      end
    end
  end

  describe "#logged_in?" do
    context "when user is logged in" do
      before { log_in(user) }

      it "returns true" do
        expect(logged_in?).to be_truthy
      end
    end

    context "when no user is logged in" do
      it "returns false" do
        expect(logged_in?).to be_falsey
      end
    end
  end
end
