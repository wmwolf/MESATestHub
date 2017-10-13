class CreateTestDatum < ActiveRecord::Migration[5.1]
  def change
    create_table :test_data do |t|
      t.string :name, null:false
      t.string :string_val
      t.float :float_val
      t.integer :integer_val
      t.boolean :boolean_val
      t.references :test_instance, foreign_key: true, null: false

      t.timestamps
    end
  end
end
