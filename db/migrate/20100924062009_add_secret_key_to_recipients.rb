class AddSecretKeyToRecipients < ActiveRecord::Migration
  def self.up
    add_column :recipients, :secret_key, :text
  end

  def self.down
    remove_column :recipients, :secret_key
  end
end
