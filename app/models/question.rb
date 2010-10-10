class Question < ActiveRecord::Base
  belongs_to :survey
  
  has_many :answers, :dependent => :destroy
  
  accepts_nested_attributes_for :answers, :reject_if => lambda { |a| a[:content].blank? },
                                          :allow_destroy => true
                                          
  default_scope :order => "questions.position DESC"
end


# == Schema Information
#
# Table name: questions
#
#  id            :integer         not null, primary key
#  survey_id     :integer
#  content       :text
#  response_type :text
#  order         :integer
#  created_at    :datetime
#  updated_at    :datetime
#  kind          :string(255)
#

