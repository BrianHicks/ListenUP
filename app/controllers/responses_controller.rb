class ResponsesController < ApplicationController
  def index
    @responses = Response.all
  end
  
  def show
    @response = Response.find(params[:id])
  end
  
  def new
    @response = Response.new
  end
  
  def create
    if params[:survey]
      modified_params = { :content => params[:survey].inspect.to_s, :survey_id => params[:survey][:id] }
      @response = Response.new(modified_params)
    else
      @response = Response.new(params[:response])
    end
    if @response.save
      flash[:notice] = "Successfully created response."
      redirect_to @response
    else
      render :action => 'new'
    end
  end
  
  def edit
    @response = Response.find(params[:id])
  end
  
  def update
    @response = Response.find(params[:id])
    if @response.update_attributes(params[:response])
      flash[:notice] = "Successfully updated response."
      redirect_to @response
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @response = Response.find(params[:id])
    @response.destroy
    flash[:notice] = "Successfully destroyed response."
    redirect_to responses_url
  end
end
