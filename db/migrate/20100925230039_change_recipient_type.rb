class ChangeRecipientType < ActiveRecord::Migration
  def self.up
    change_column :recipients, :email, :string
  end

  def self.down
    change_column :recipients, :email, :text
  end
end
