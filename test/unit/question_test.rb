require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
  end
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
#

