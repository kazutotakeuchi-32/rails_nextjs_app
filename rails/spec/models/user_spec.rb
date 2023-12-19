# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  context "バリデーション" do
    let(:user) { create(:user) }

    it "認証済みのユーザーは有効であること" do
      expect(user).to be_valid
      expect(user).to be_confirmed
    end
  end
end
