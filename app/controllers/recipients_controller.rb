class RecipientsController < ApplicationController
  before_filter :authenticate_user!, :only => [:index, :new, :create, :destroy]
  def index
    @recipients = Recipient.all
  end
  
  def show
    @recipient = Recipient.find(params[:id])
  end
  
  def new
    @recipient = Recipient.new
  end
  
  def create
    @recipient = Recipient.new(params[:recipient])
    @recipient.secret_key = @recipient.generate_secret
    if @recipient.save
      flash[:notice] = "Successfully created recipient."
      redirect_to @recipient
    else
      render :action => 'new'
    end
  end
  
  def edit
    @recipient = Recipient.find(params[:id])
    if @recipient.secret != params[:secret]
      redirect_to surveys_path
      flash[:error] = "You don't have permission to edit that recipient."
    end
  end
  
  def update
    @recipient = Recipient.find(params[:id])
    if @recipient.secret_key == params[:secret_key]
      redirect_to root_path and return
    end
    if @recipient.update_attributes(params[:recipient])
      flash[:notice] = "Successfully updated recipient."
      redirect_to @recipient
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @recipient = Recipient.find(params[:id])
    @recipient.destroy
    flash[:notice] = "Successfully destroyed recipient."
    redirect_to recipients_url
  end
end
