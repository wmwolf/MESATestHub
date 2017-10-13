class CreateTestInstance < ActiveRecord::Migration[5.1]
  def change
    create_table :test_instances do |t|
      t.datetime :start
      t.datetime :finish
      t.integer :runtime_seconds, null: false
      t.integer :mesa_version, null: false
      t.integer :omp_num_threads
      t.string :compiler
      t.string :compiler_version
      t.string :platform_version
      t.boolean :passed, null: false
      t.references :computer, foreign_key: true, null:false
      t.references :test_case, foreign_key: true, null:false

      t.timestamps
    end
  end
end
