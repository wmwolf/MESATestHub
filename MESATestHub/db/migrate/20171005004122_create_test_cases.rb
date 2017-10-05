class CreateTestCases < ActiveRecord::Migration[5.1]
  def change
    create_table :test_cases do |t|
      t.string :name, null: false
      t.integer :version_added
      t.text :description
      t.integer :last_version_status
      t.integer :last_test_status
      t.datetime :last_tested
      t.string :datum_1_name
      t.string :datum_1_type
      t.string :datum_2_name
      t.string :datum_2_type
      t.string :datum_3_name
      t.string :datum_3_type
      t.string :datum_4_name
      t.string :datum_4_type
      t.string :datum_5_name
      t.string :datum_5_type
      t.string :datum_6_name
      t.string :datum_6_type
      t.string :datum_7_name
      t.string :datum_7_type
      t.string :datum_8_name
      t.string :datum_8_type
      t.string :datum_9_name
      t.string :datum_9_type
      t.string :datum_10_name
      t.string :datum_10_type

      t.timestamps
    end
  end
end
