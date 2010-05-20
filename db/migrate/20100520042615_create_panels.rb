class CreatePanels < ActiveRecord::Migration
  def self.up
    create_table :panels do |t|
      t.text :title
      t.integer :project_id

      t.timestamps
    end
  end

  def self.down
    drop_table :panels
  end
end
