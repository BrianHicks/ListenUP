class SurveysController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def index
    @surveys = current_user.is_admin? ? Survey.all : current_user.surveys
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
    5.times { @survey.recipients.build }
    @survey.editors.build
  end
  
  def create
    @survey = Survey.new(params[:survey])
    modify_editors(params, @survey) unless params[:survey][:editors_attributes].nil?
    @survey.owner_id = current_user.id
    if @survey.save
      current_user.surveys << @survey
      flash[:notice] = "Successfully created survey."
      redirect_to @survey
    else
      render :action => 'new'
    end
  end
  
  def edit
    @survey = Survey.find(params[:id])
    @survey.editors.build if @survey.editors.count == 0
    if !@survey.can_be_edited_by? current_user
      flash[:error] = "You don't have permission to edit this survey."
      redirect_to surveys_url
    end
  end
  
  def update
    @survey = Survey.find(params[:id])
    
    # grab two arrays. One with the requested emails, one with existing emails inside requested emails
    emails = params[:survey][:recipients_attributes].map { |r| r[1]["email"] }
    existing_emails = Recipient.where(:email => emails).map{ |r| r.email  }
    
    new_emails = emails - existing_emails
    
    modify_editors(params, @survey)
    for email in new_emails do
      r = Recipient.create!(:email => email)
    end

    if @survey.update_attributes(params[:survey])
      flash[:notice] = "Successfully updated survey."
      render :action => 'edit'
      #redirect_to @survey
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
    if @survey.sent_count < 3
      for recipient in @survey.recipients do
        SurveyMailer.survey_email(@survey, recipient).deliver unless recipient.no_email
      end
      @survey.sent_count += 1
      @survey.save
      flash[:notice] = "Sent survey! (Sent #{@survey.sent_count} of 3 times.)"
    else 
      flash[:error] = "You cannot send a survey more than 3 times."
    end
    
    redirect_to surveys_url
  end
  
  private
  
    def modify_editors(params, survey)
      editors = survey.editors.map { |e| e.email }
      users = User.all.map { |u| u.email }
      emails = []
      for id in params[:survey][:editors_attributes].keys do
        emails << params[:survey][:editors_attributes][id][:email]
      end
      # add new users@
      for email in emails do
        if users.include?(email) && !editors.include?(email)
          user = User.find_by_email(email)
          survey.editors << user
          user.surveys << survey
        end
      end
      # delete old users
      for id in params[:survey][:editors_attributes].keys do
        if params[:survey][:editors_attributes][id][:_destroy] == "1"
          email = params[:survey][:editors_attributes][id][:email]
          user = User.find_by_email(email)
          survey.editors.delete(user)
          user.surveys.delete(survey)
        end
      end
    end
end
