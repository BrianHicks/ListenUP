class SurveyMailer < ActionMailer::Base
  default :from => "surveys@example.com"
  
  def survey_email(survey)
    @owner = survey.owner
    for recipient in survey.recipients
      mail (:to => recipient.email,
            :from => @owner.email,
            :subject => "You've been invited to take a survey!")
    end
  end
end
