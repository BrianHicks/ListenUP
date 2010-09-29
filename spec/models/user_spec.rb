require 'spec_helper'

describe User do
  before :each do
    @user = User.make
  end
  
  it "should return the full name for full_name" do
    @user.full_name.should eql("#{@user.first_name} #{@user.last_name}")
  end
end
