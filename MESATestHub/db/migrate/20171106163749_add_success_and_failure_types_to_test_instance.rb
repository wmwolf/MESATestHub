class AddSuccessAndFailureTypesToTestInstance < ActiveRecord::Migration[5.1]
  def up
    add_column :test_instances, :success_type, :string
    add_column :test_instances, :failure_type, :string
  end
  def down
    remove_column :test_instances, :success_type
    remove_column :test_instances, :failure_type
  end

end
