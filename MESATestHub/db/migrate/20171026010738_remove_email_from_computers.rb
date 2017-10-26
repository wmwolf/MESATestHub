class RemoveEmailFromComputers < ActiveRecord::Migration[5.1]
  def up
    remove_column :computers, :email
  end
  def down
    add_column :computer, email: :string
  end
end
