class AddIndicesToTestCases < ActiveRecord::Migration[5.1]
  def up
    add_index :test_cases, :name, unique: true
  end

  def down
    remove_index :test_cases, :name
  end
end
