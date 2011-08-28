class CreateDvds < ActiveRecord::Migration
  def self.up
    create_table :dvds do |t|
      t.string :name
	  t.string :beschreibung
      t.integer :verliehen
	  t.string :userid
	  t.integer :anzahl

      t.timestamps
    end
  end

  def self.down
    drop_table :dvds
  end
end
