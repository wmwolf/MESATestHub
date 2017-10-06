class AddLastVersionToTestCases < ActiveRecord::Migration[5.1]
  def change
    add_column :test_cases, :last_version, :integer
  end
end
