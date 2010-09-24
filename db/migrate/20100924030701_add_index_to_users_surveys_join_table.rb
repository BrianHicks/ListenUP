class AddIndexToUsersSurveysJoinTable < ActiveRecord::Migration
  def self.up
    add_index :users_surveys, :survey_id
    add_index :users_surveys, :user_id
  end

  def self.down
    remove_index :users_surveys, :survey_id
    remove_index :users_surveys, :user_id
  end
end
