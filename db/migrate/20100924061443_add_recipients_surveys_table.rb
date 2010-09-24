class AddRecipientsSurveysTable < ActiveRecord::Migration
  def self.up
    create_table :recipients_surveys, :id => false do |t|
      t.integer :recipient_id
      t.integer :survey_id
    end
    add_index :recipients_surveys, :recipient_id
    add_index :recipients_surveys, :survey_id
  end

  def self.down
    drop_table :recipients_surveys
  end
end
