class CreateDvds < ActiveRecord::Migration
  def self.up
    create_table :dvds do |t|
      t.string :name
	  t.string :beschreibung
      t.boolean :verliehen
	  t.integer :userid
	  t.integer :anzahl

      t.timestamps
    end
  end

  def self.down
    drop_table :dvds
  end
end
