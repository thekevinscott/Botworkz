class DropTextAddContent < ActiveRecord::Migration
  def self.up
    remove_column :notes, :text
    add_column :notes, :content, :text    
  end

  def self.down
    remove_column :notes, :content
    add_column :notes, :text, :text    
  end
end
