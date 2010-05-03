class CreateNotes < ActiveRecord::Migration
  def self.up
    create_table :notes do |t|
      t.text :text
      t.integer :project_id
      t.integer :client_id
      t.integer :user_id
      t.integer :rev

      t.timestamps
    end
  end

  def self.down
    drop_table :notes
  end
end
