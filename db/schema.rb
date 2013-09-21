# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120320074601) do

  create_table "accessories", :force => true do |t|
    t.integer  "item_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignment_histories", :force => true do |t|
    t.integer  "item_id"
    t.integer  "project_id"
    t.integer  "item_price"
    t.integer  "qty"
    t.integer  "user_making_qoute_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "brands", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "clients", :force => true do |t|
    t.string   "name",            :limit => 120
    t.string   "contact_person",  :limit => 120
    t.string   "contact_details", :limit => 150
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.string   "full_name",           :limit => 120
    t.datetime "date_of_birth"
    t.string   "designation",         :limit => 50
    t.string   "sss",                 :limit => 20
    t.string   "pag_ibig",            :limit => 20
    t.string   "phil_health",         :limit => 20
    t.string   "bank_account_number", :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_assets", :force => true do |t|
    t.integer  "item_id"
    t.integer  "parent_id"
    t.string   "content_type"
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "size"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_disbursements", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "comment"
    t.string   "status"
  end

  create_table "item_releases", :force => true do |t|
    t.integer  "item_disbursement_id"
    t.integer  "item_id"
    t.integer  "qty"
    t.datetime "released_at"
    t.boolean  "is_returnable",        :default => true
    t.boolean  "all_returned",         :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "date_returned"
    t.integer  "returned_qty",         :default => 0
    t.integer  "last_borrowed_qty"
  end

  create_table "item_returns", :force => true do |t|
    t.integer  "qty"
    t.integer  "item_disbursement_id"
    t.datetime "returned_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
    t.integer  "recieved_by_id"
  end

  create_table "item_specifics", :force => true do |t|
    t.integer  "supplier_id"
    t.integer  "brand_id"
    t.integer  "item_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "item_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", :force => true do |t|
    t.string   "name"
    t.integer  "measurement_id"
    t.integer  "reorder_qty",         :default => 1
    t.integer  "current_qty",         :default => 0
    t.integer  "item_asset_id"
    t.string   "serial_number"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "storage_location_id"
    t.integer  "brand_id"
    t.string   "barcode"
    t.string   "status"
    t.string   "description"
    t.string   "type_of"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.string   "remarks"
    t.string   "image_filename"
    t.integer  "unit_id"
  end

  create_table "man_power_assignment_histories", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "project_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "man_power_assignments", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "status",      :default => true
  end

  create_table "measurements", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "problems", :force => true do |t|
    t.integer  "employee_id"
    t.integer  "project_id"
    t.text     "report"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.boolean  "is_test",                            :default => false
    t.boolean  "is_active",                          :default => true
    t.integer  "profit_margin"
    t.date     "start_date"
    t.date     "estimated_end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "client_id"
    t.string   "project_unique_id"
    t.integer  "assigned_employee_id"
    t.string   "status",               :limit => 30, :default => "OPEN"
  end

  create_table "purchase_order_details", :force => true do |t|
    t.integer  "item_id"
    t.integer  "qty"
    t.integer  "purchase_order_id"
    t.integer  "unit_price"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchase_orders", :force => true do |t|
    t.text     "or"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "supplier_id"
    t.string   "status",              :default => "Open"
    t.text     "comment"
    t.integer  "supplier_contact_id"
    t.integer  "project_id"
    t.integer  "requested_by"
    t.integer  "approve_by"
    t.integer  "terms"
    t.string   "delivery_date"
  end

  create_table "purchase_recieve_details", :force => true do |t|
    t.integer  "purchase_recieve_id"
    t.integer  "item_id"
    t.integer  "qty_received"
    t.integer  "receive_by_user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "purchase_recieves", :force => true do |t|
    t.integer  "purchase_order_id"
    t.integer  "supplier_id"
    t.text     "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "storage_locations", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_contact_infos", :force => true do |t|
    t.integer  "supplier_id"
    t.integer  "contact_type_id"
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_contact_names", :force => true do |t|
    t.string   "name"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_contacts", :force => true do |t|
    t.string   "name"
    t.integer  "contact_type_id"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "supplier_price_histories", :force => true do |t|
    t.integer  "supplier_id"
    t.integer  "item_id"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",            :limit => 100
    t.string   "contact_person"
    t.string   "contact_details"
  end

  create_table "units", :force => true do |t|
    t.string "name"
  end

  create_table "user_contact_infos", :force => true do |t|
    t.text     "data"
    t.integer  "contact_type_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                     :limit => 40
    t.string   "name",                      :limit => 100, :default => ""
    t.string   "email",                     :limit => 100
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
    t.boolean  "is_admin",                                 :default => false
    t.string   "itype",                     :limit => 30
  end

  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
