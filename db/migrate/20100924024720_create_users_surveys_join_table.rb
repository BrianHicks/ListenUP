class CreateUsersSurveysJoinTable < ActiveRecord::Migration
  def self.up
    create_table :users_surveys, :id => false do |t|
      t.integer :user_id
      t.integer :survey_id
    end
  end

  def self.down
    drop_table :users_surveys
  end
end
