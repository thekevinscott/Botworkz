class AddUrlToProjects < ActiveRecord::Migration
  def self.up
    add_column :projects, :url, :text
    add_column :clients, :url, :text    
  end

  def self.down
    remove_column :projects, :url
    remove_column :clients, :url
  end
end
