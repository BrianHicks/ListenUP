class Survey < ActiveRecord::Base
  #attr_accessible :name, :intro, :thank_you, :pub_date, :end_date, :pub_id
  
  has_many :questions, :dependent => :destroy
  
  has_and_belongs_to_many :editors, :class_name => "User"
  has_and_belongs_to_many :recipients

  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? },
                                            :allow_destroy => true
  accepts_nested_attributes_for :recipients, :reject_if => lambda { |a| a[:email].blank? }
  accepts_nested_attributes_for :editors, :reject_if => lambda { |a| true }
                                            
  def is_owner?(user)
    user == owner
  end
  
  def can_be_edited_by?(user)
    editors.include?(user) || is_owner(user) || user.is_admin?
  end
  
  def owner
    User.find(owner_id)
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

