class Survey < ActiveRecord::Base
  #attr_accessible :name, :intro, :thank_you, :pub_date, :end_date, :pub_id
  
  has_many :questions, :dependent => :destroy

  accepts_nested_attributes_for :questions, :reject_if => lambda { |a| a[:content].blank? },
                                            :allow_destroy => true
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
#

