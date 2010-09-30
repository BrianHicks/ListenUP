require 'spec_helper'

describe User do
  before :each do
    @user = User.make
    @admin = User.make(:admin)
  end

  describe "for any user" do    
    it { @user.full_name.should eql("#{@user.first_name} #{@user.last_name}") }
  end
  
  describe "for a regular user" do
    it { @user.is_admin?.should_not be_true }
  end
  
  describe "for an admin" do
    it { @admin.is_admin?.should be_true }
  end
end
