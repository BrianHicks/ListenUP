class CreateSurveys < ActiveRecord::Migration
  def self.up
    create_table :surveys do |t|
      t.string :name
      t.string :intro
      t.string :thank_you
      t.datetime :pub_date
      t.datetime :end_date
      t.string :pub_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :surveys
  end
end
