class AddSentCountToSurveys < ActiveRecord::Migration
  def self.up
    add_column :surveys, :sent_count, :integer, :default => 0
  end

  def self.down
    add_column :surveys, :sent_count
  end
end
