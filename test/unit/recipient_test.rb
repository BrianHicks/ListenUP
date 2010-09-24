require 'test_helper'

class RecipientTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Recipient.new.valid?
  end
end
