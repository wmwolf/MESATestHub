class AddIndicesToTestInstances < ActiveRecord::Migration[5.1]
  def up
    add_index :test_instances, :mesa_version
  end

  def down
    remove_index :test_instances, :mesa_version
  end
end
