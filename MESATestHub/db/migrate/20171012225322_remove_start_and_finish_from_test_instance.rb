class RemoveStartAndFinishFromTestInstance < ActiveRecord::Migration[5.1]
  def up
    remove_column :test_instances, :start
    remove_column :test_instances, :finish
  end

  def down
    add_column :test_instances, :start, :datetime
    add_column :test_instances, :finish, :datetime
  end
end
