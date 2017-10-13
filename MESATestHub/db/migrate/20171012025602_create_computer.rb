class CreateComputer < ActiveRecord::Migration[5.1]
  def change
    create_table :computers do |t|
      t.string :name, null: false
      t.string :user
      t.string :email
      t.string :platform
      t.string :processor
      t.integer :ram_gb

      t.timestamps      
    end
  end
end
