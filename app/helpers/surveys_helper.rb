module SurveysHelper

  def user_facing_question(f, q) #form, question
    case q.object.kind
      when "select"
        q_with_as(q, :select)
      when "radio"
        q_with_as(q, :radio)
      when "text"
        q.input :content, :label => q.object.content, :as => :string
      when "check_boxes"
        q_with_as(q, :check_boxes)
      when "agreescale"
        q_with_collection(q, ["Strongly Agree", "Agree", "Neutral", "Disagree", "Strongly Disagre"])
      when "describesscale"
        q_with_collection(q, ["Describes Me", "Sort of Describes Me", "Neutral", "Does not really describe me", "Definitely Does not Describe Me"])
      when "section_header"
        haml_tag :h2, q.object.content
    end
  end
  
  def q_with_as(q, as)
    q.input :content, 
    :label => q.object.content, 
    :collection => q.object.answers.map { |a| a.content }, 
    :as => as
  end
  
  def q_with_collection(q, collection)
    q.input :content,
     :label => q.object.content, 
     :collection => collection, 
     :as => :radio,
     :input_html => { :class => 'scale' }
  end
  
end
