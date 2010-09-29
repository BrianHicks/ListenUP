class Answer < ActiveRecord::Base
  belongs_to :question
end

# == Schema Information
#
# Table name: answers
#
#  id          :integer         not null, primary key
#  question_id :integer
#  content     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

