class TieProjectsAndClientsToUser < ActiveRecord::Migration
  def self.up
    add_column :projects, :user_id, :integer
    add_column :clients, :user_id, :integer    
  end

  def self.down
    remove_column :projects, :user_id
    remove_column :clients, :user_id    
  end
end
