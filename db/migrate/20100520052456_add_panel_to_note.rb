class AddPanelToNote < ActiveRecord::Migration
  def self.up
    add_column :notes, :panel_id, :integer
  end

  def self.down
    remove_column :notes, :panel_id
  end
end
