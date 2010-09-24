class RenameUsersSurveysToSurveysUsers < ActiveRecord::Migration
  def self.up
    rename_table :users_surveys, :surveys_users
  end

  def self.down
    rename_table :surveys_users, :users_surveys
  end
end
