require 'rails_helper'

RSpec.describe User, type: :model do
  describe "model validations" do 
    it "requires email" do
      user = build(:user, email: "")
      expect(user.valid?).to be false
    end
  end

  describe "model methods" do 
    it "sets default 'user' role to user upon initialization" do 
      user = create(:user)
      expect(user.role).to eq("user")
    end
  end 

  
end
