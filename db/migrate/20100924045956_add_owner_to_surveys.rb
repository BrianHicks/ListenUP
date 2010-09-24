class AddOwnerToSurveys < ActiveRecord::Migration
  def self.up
    add_column :surveys, :owner_id, :text
  end

  def self.down
    remove_column :surveys, :owner_id
  end
end
