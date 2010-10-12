class Response < ActiveRecord::Base
  belongs_to :survey
  
  def questions
    Survey.find(survey_id).questions
  end
end

# == Schema Information
#
# Table name: responses
#
#  id         :integer         not null, primary key
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#  survey_id  :integer
#

