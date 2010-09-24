class SurveysController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def index
    @surveys = current_user.surveys
  end
  
  def show
    @survey = Survey.find(params[:id])
  end
  
  def new
    @survey = Survey.new
    3.times do
      question = @survey.questions.build
      3.times { question.answers.build }
    end
  end
  
  def create
    @survey = Survey.new(params[:survey])
    @survey.owner_id = current_user.id
    if @survey.save
      flash[:notice] = "Successfully created survey."
      redirect_to @survey
    else
      render :action => 'new'
    end
  end
  
  def edit
    @survey = Survey.find(params[:id])
    if !@survey.can_be_edited_by? current_user
      flash[:error] = "You don't have permission to edit this survey."
      redirect_to surveys_url
    end
  end
  
  def update
    @survey = Survey.find(params[:id])
    if @survey.update_attributes(params[:survey])
      flash[:notice] = "Successfully updated survey."
      redirect_to @survey
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @survey = Survey.find(params[:id])
    if @survey.is_owner?(current_user)
      @survey.destroy
      flash[:notice] = "Successfully destroyed survey."
    else
      flash[:error] = "You don't have permission to destroy this survey."
    end
    redirect_to surveys_url
  end
  
  def deliver
    @survey = Survey.find(params[:id])
    for recipient in @survey.recipients do
      SurveyMailer.survey_email(@survey, recipient).deliver
    end
    flash[:notice] = "Sent survey!"
    redirect_to surveys_url
  end
end
