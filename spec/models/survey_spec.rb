require 'spec_helper'

describe Survey do
  before :each do
    @user = User.make
    @editor = User.make
    @owner = User.make
    @admin = User.make(:admin)
    @admin.owner_id = @owner.id
    @admin.editors << @editor
  end
  
  describe "the survey itself" do
    it "should return the correct owner id"
  end
  
  describe "for the owner" do
    it "should be editable"
    it "should be the owner"
  end
  
  describe "for an admin" do
    it "should be editable"
    it "should not be the owner"
  end
  
  describe "for an editor" do
    it "should be editable"
    it "should not be the owner"
  end
  
  describe "for any user" do
    it "should not be editable"
    it "should not be the owner"
  end
end

# == Schema Information
#
# Table name: surveys
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  intro      :string(255)
#  thank_you  :string(255)
#  pub_date   :datetime
#  end_date   :datetime
#  pub_id     :string(255)
#  created_at :datetime
#  updated_at :datetime
#  owner_id   :integer
#

