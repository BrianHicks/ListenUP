class CreateRecipients < ActiveRecord::Migration
  def self.up
    create_table :recipients do |t|
      t.text :email
      t.boolean :no_email, :default => false
      t.timestamps
    end
  end
  
  def self.down
    drop_table :recipients
  end
end
