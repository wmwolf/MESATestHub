class AddIndicesToComputers < ActiveRecord::Migration[5.1]
  def up
    add_index :computers, :name, unique: true
  end

  def down
    remove_index :computers, :name
  end
end
