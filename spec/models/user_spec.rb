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

# == Schema Information
#
# Table name: users
#
#  id                   :integer         not null, primary key
#  email                :string(255)     default(""), not null
#  encrypted_password   :string(128)     default(""), not null
#  password_salt        :string(255)     default(""), not null
#  reset_password_token :string(255)
#  remember_token       :string(255)
#  remember_created_at  :datetime
#  sign_in_count        :integer         default(0)
#  current_sign_in_at   :datetime
#  last_sign_in_at      :datetime
#  current_sign_in_ip   :string(255)
#  last_sign_in_ip      :string(255)
#  first_name           :string(255)
#  last_name            :string(255)
#  is_admin             :boolean
#  pub_id               :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#

