require 'digest/md5'

class Recipient < ActiveRecord::Base
  attr_accessible :email, :no_email, :secret_key
  
  has_and_belongs_to_many :surveys
  
  def secret
    Digest::MD5.hexdigest(email).to_s.slice(0,8)
  end
end

# == Schema Information
#
# Table name: recipients
#
#  id         :integer         not null, primary key
#  email      :string(255)
#  no_email   :boolean         default(FALSE)
#  created_at :datetime
#  updated_at :datetime
#  secret_key :text
#

