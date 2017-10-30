class AddModuleToTestCase < ActiveRecord::Migration[5.1]
  def change
    add_column :test_cases, :module, :string
  end
end
