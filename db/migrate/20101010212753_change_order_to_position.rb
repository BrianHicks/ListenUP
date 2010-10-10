class ChangeOrderToPosition < ActiveRecord::Migration
  def self.up
    rename_column :questions, :order, :position
  end

  def self.down
    rename_column :questions, :position, :order
  end
end
