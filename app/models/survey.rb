class Survey < ActiveRecord::Base
  attr_accessible :name, :intro, :thank_you, :pub_date, :end_date, :pub_id
end
