# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20171005005754) do

  create_table "test_cases", force: :cascade do |t|
    t.string "name", null: false
    t.integer "version_added"
    t.text "description"
    t.integer "last_version_status"
    t.integer "last_test_status"
    t.datetime "last_tested"
    t.string "datum_1_name"
    t.string "datum_1_type"
    t.string "datum_2_name"
    t.string "datum_2_type"
    t.string "datum_3_name"
    t.string "datum_3_type"
    t.string "datum_4_name"
    t.string "datum_4_type"
    t.string "datum_5_name"
    t.string "datum_5_type"
    t.string "datum_6_name"
    t.string "datum_6_type"
    t.string "datum_7_name"
    t.string "datum_7_type"
    t.string "datum_8_name"
    t.string "datum_8_type"
    t.string "datum_9_name"
    t.string "datum_9_type"
    t.string "datum_10_name"
    t.string "datum_10_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "test_data", force: :cascade do |t|
    t.string "name", null: false
    t.string "string_val"
    t.float "float_val"
    t.integer "integer_val"
    t.boolean "boolean_val"
    t.integer "instance_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instance_id"], name: "index_test_data_on_instance_id"
  end

  create_table "test_instances", force: :cascade do |t|
    t.datetime "start"
    t.datetime "finish"
    t.integer "runtime_seconds", null: false
    t.integer "mesa_version", null: false
    t.integer "omp_num_threads"
    t.string "compiler"
    t.string "compiler_version"
    t.string "platform_version"
    t.boolean "passed", null: false
    t.integer "computer_id", null: false
    t.integer "test_case_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["computer_id"], name: "index_test_instances_on_computer_id"
    t.index ["test_case_id"], name: "index_test_instances_on_test_case_id"
  end

end
