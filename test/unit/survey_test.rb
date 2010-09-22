require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Survey.new.valid?
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
#

