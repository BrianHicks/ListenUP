class SurveysController < ApplicationController
  before_filter :authenticate_user!, :except => [:show]

  def index
    @surveys = current_user.is_admin? ? Survey.all : current_user.surveys
    @title = "Surveys"
  end
  
  def show
    @survey = Survey.find(params[:id])
    @title = @survey.name
  end
  
  def new
    @survey = Survey.new
    @title = "New Survey"
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
    @title = "Editing '#{@survey.name}'"
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
  
  def thanks
    @survey = Survey.find(params[:id])
    @title = @survey.name
  end
  
  def export
    @survey = Survey.find(params[:id])
    if @survey.is_owner?(current_user)
      headers["Content-Type"] = "application/vnd.ms-excel"
      headers['Content-Disposition'] = 'attachment; filename="' + Time.now.to_s + ' - ' + @survey.name + '.xls"'
      headers['Cache-Control'] = ''
      
      @data = {}
      @data["headers"] = @survey.questions.map { |q| q.content }
      @data["responses"] = []
      @survey.responses.each do |r|
        r_content = eval(r.content)["questions_attributes"]
        r_answers = r_content.map { |a| a[1]["content"] }
        r_answers.map! do |a|
          if a.class == Array
            a.reject { |sub| sub.empty? }.join(", ")
          else
            a
          end
        end
        @data["responses"].push(r_answers)
      end
      
      render :layout => false
    else
      flash[:error] = "Only the owner can download surveys."
      redirect_to surveys_url
    end
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
