# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150627164317) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_courses", force: true do |t|
    t.integer  "category_id"
    t.integer  "course_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories_courses", ["category_id"], name: "index_categories_courses_on_category_id"
  add_index "categories_courses", ["course_id"], name: "index_categories_courses_on_course_id"

  create_table "categories_tools", force: true do |t|
    t.integer  "tool_id"
    t.integer  "category_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "categories_tools", ["category_id"], name: "index_categories_tools_on_category_id"
  add_index "categories_tools", ["tool_id"], name: "index_categories_tools_on_tool_id"

  create_table "courses", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.text     "additional_info"
    t.integer  "recertification"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["category_id"], name: "index_courses_on_category_id"

  create_table "courses_people", force: true do |t|
    t.integer  "course_id"
    t.integer  "person_id"
    t.date     "date_requested"
    t.string   "approver"
    t.boolean  "approved"
    t.date     "approval_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses_people", ["course_id"], name: "index_courses_people_on_course_id"
  add_index "courses_people", ["person_id"], name: "index_courses_people_on_person_id"

  create_table "documentation_links", force: true do |t|
    t.string   "name"
    t.string   "external_link"
    t.integer  "course_id"
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "documentation_links", ["course_id"], name: "index_documentation_links_on_course_id"

  create_table "forms", force: true do |t|
    t.string   "name"
    t.text     "external_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "forms_people", force: true do |t|
    t.integer  "person_id"
    t.integer  "form_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "forms_people", ["form_id"], name: "index_forms_people_on_form_id"
  add_index "forms_people", ["person_id"], name: "index_forms_people_on_person_id"

  create_table "hour_exceptions", force: true do |t|
    t.datetime "time_beginning"
    t.datetime "time_ending"
    t.integer  "person_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hour_exceptions", ["person_id"], name: "index_hour_exceptions_on_person_id"

  create_table "hours", force: true do |t|
    t.time     "time_open"
    t.time     "time_close"
    t.integer  "person_id"
    t.integer  "day_of_week"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "hours", ["person_id"], name: "index_hours_on_person_id"

  create_table "maintenance_actions", force: true do |t|
    t.date     "date"
    t.integer  "tool_id"
    t.integer  "person_id"
    t.integer  "maintenance_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "maintenance_actions", ["maintenance_type_id"], name: "index_maintenance_actions_on_maintenance_type_id"
  add_index "maintenance_actions", ["person_id"], name: "index_maintenance_actions_on_person_id"
  add_index "maintenance_actions", ["tool_id"], name: "index_maintenance_actions_on_tool_id"

  create_table "maintenance_types", force: true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.integer  "required_days_between_maintenance"
    t.text     "instructions"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "maintenance_types", ["category_id"], name: "index_maintenance_types_on_category_id"

  create_table "people", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.integer  "graduation_year"
    t.string   "barcode"
    t.string   "emergency_contact_name"
    t.string   "emergency_contact_number"
    t.boolean  "archived"
    t.boolean  "is_admin"
    t.boolean  "is_student_admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "space_reservations", force: true do |t|
    t.integer  "person_id"
    t.integer  "space_id"
    t.datetime "reservation_beginning"
    t.datetime "reservation_ending"
    t.integer  "number_of_people"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "space_reservations", ["person_id"], name: "index_space_reservations_on_person_id"
  add_index "space_reservations", ["space_id"], name: "index_space_reservations_on_space_id"

  create_table "spaces", force: true do |t|
    t.string   "name"
    t.integer  "max_people"
    t.boolean  "reservable"
    t.integer  "max_reservable_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "timelogs", force: true do |t|
    t.integer  "person_id"
    t.datetime "time_beginning"
    t.datetime "time_ending"
    t.integer  "duration"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timelogs", ["person_id"], name: "index_timelogs_on_person_id"

  create_table "tool_logs", force: true do |t|
    t.integer  "tool_id"
    t.integer  "person_id"
    t.datetime "time_beginning"
    t.datetime "time_ending"
    t.integer  "duration"
    t.integer  "tool_reservation_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tool_logs", ["person_id"], name: "index_tool_logs_on_person_id"
  add_index "tool_logs", ["tool_id"], name: "index_tool_logs_on_tool_id"
  add_index "tool_logs", ["tool_reservation_id"], name: "index_tool_logs_on_tool_reservation_id"

  create_table "tool_reservations", force: true do |t|
    t.integer  "person_id"
    t.integer  "tool_id"
    t.datetime "reservation_beginning"
    t.datetime "reservation_ending"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tool_reservations", ["person_id"], name: "index_tool_reservations_on_person_id"
  add_index "tool_reservations", ["tool_id"], name: "index_tool_reservations_on_tool_id"

  create_table "tools", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "image"
    t.string   "serial"
    t.string   "barcode"
    t.date     "date_purchased"
    t.text     "capability"
    t.boolean  "reservable"
    t.integer  "max_reservation_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
