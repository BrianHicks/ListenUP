require 'test_helper'

class RecipientsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => Recipient.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    Recipient.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end
  
  def test_create_valid
    Recipient.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to recipient_url(assigns(:recipient))
  end
  
  def test_edit
    get :edit, :id => Recipient.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    Recipient.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Recipient.first
    assert_template 'edit'
  end
  
  def test_update_valid
    Recipient.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Recipient.first
    assert_redirected_to recipient_url(assigns(:recipient))
  end
  
  def test_destroy
    recipient = Recipient.first
    delete :destroy, :id => recipient
    assert_redirected_to recipients_url
    assert !Recipient.exists?(recipient.id)
  end
end
