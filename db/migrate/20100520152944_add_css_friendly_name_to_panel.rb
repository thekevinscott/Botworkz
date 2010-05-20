class AddCssFriendlyNameToPanel < ActiveRecord::Migration
  def self.up
    add_column :panels, :css_name, :string
  end

  def self.down
    remove_column :panels, :css_name
  end
end
