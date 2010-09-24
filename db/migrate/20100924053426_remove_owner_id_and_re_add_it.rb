class RemoveOwnerIdAndReAddIt < ActiveRecord::Migration
  def self.up
    remove_column :surveys, :owner_id
    add_column :surveys, :owner_id, :integer
    add_index :surveys, :owner_id
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration
  end
end
