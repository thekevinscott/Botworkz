class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.string :name
      t.integer :rate
      t.text :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :clients
  end
end
