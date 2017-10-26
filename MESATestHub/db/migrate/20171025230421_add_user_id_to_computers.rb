class AddUserIdToComputers < ActiveRecord::Migration[5.1]
  def up
    add_reference :computers, :user, index: true
  end

  def down
    remove_reference :computers, :user
  end
end
