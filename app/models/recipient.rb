require 'digest/md5'

class Recipient < ActiveRecord::Base
  attr_accessible :email, :no_email, :secret_key
  
  has_and_belongs_to_many :surveys
  
  def generate_secret
    Digest::MD5.hexdigest(email)
  end
end
