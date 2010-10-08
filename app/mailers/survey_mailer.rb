class SurveyMailer < ActionMailer::Base
  default :from => "surveys@example.com"
  
  def survey_email(survey, recipient)
    @owner = survey.owner
    @survey = survey
    @recipient = recipient
    mail(:to => recipient.email,
         :from => @owner.email,
         :subject => "You've been invited to take a survey!") unless recipient.no_email
  end
end
