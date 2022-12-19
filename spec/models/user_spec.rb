require 'rails_helper'

RSpec.describe User, type: :model do
  describe "model validations" do 
    it "requires email" do
      user = build(:user, email: "")
      expect(user.valid?).to be false
    end
  end 
end
