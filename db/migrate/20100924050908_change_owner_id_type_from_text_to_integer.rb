class ChangeOwnerIdTypeFromTextToInteger < ActiveRecord::Migration
  def self.up
    change_column :surveys, :owner_id, :integer
  end

  def self.down
    change_column :surveys, :owner_id, :text
  end
end
