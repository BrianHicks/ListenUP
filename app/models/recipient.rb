class Recipient < ActiveRecord::Base
  attr_accessible :email, :no_email
  
  has_and_belongs_to_many :surveys
end
