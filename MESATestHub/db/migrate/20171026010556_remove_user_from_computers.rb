class RemoveUserFromComputers < ActiveRecord::Migration[5.1]
  def up
    remove_column :computers, :user
  end

  def down
    add_column :computers, user: :string
  end
end
