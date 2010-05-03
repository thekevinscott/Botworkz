class AddArchiveToProject < ActiveRecord::Migration
  def self.up
    add_column :projects, :archive, :boolean
  end

  def self.down
    remove_column :projects, :archive
  end
end
