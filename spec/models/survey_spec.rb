require 'spec_helper'

describe Survey do
  before :all do
    @user = User.make!
    @editor = User.make!
    @owner = User.make!
    @admin = User.make!(:admin)
    @survey = Survey.make!
    @survey.owner_id = @owner.id
    @survey.save!
    @survey.editors << @editor
  end
  
  describe "for the owner" do
    it "should return true for is_owner?" do
      @survey.is_owner?(@owner).should be_true
    end
    it "should return true for can_be_edited_by?" do
      @survey.can_be_edited_by?(@owner).should be_true
    end
    it "should return true for can_be_deleted_by?" do
      @survey.can_be_deleted_by?(@owner).should be_true
    end
    it "should return the owner for owner" do
      @survey.owner.should eql @owner
    end
  end
  
  describe "for an admin" do
    it "should return false for is_owner?" do
      @survey.is_owner?(@admin).should be_false
    end
    it "should return true for can_be_edited_by?" do
      @survey.can_be_edited_by?(@admin).should be_true
    end
    it "should return true for can_be_deleted_by?" do
      @survey.can_be_deleted_by?(@admin).should be_true
    end
    it "should not return the admin for owner" do
      @survey.owner.should_not eql @admin
    end
  end
  
  describe "for an editor" do
    it "should return false for is_owner?" do
      @survey.is_owner?(@editor).should be_false
    end
    it "should return true for can_be_edited_by?" do
      @survey.can_be_edited_by?(@editor).should be_true
    end
    it "should return false for can_be_deleted_by?" do
      @survey.can_be_deleted_by?(@editor).should be_false
    end
    it "should not return the editor for owner" do
      @survey.owner.should_not eql @editor
    end
  end
  
  describe "for any other user" do
    it "should return false for is_owner?" do
      @survey.is_owner?(@user).should be_false
    end
    it "should return false for can_be_edited_by?" do
      @survey.can_be_edited_by?(@user).should be_false
    end
    it "should return false for can_be_deleted_by?" do
      @survey.can_be_deleted_by?(@user).should be_false
    end
    it "should not return the editor for owner" do
      @survey.owner.should_not eql @user
    end
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

