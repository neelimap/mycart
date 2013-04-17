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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130416054523) do

  create_table "carts", :force => true do |t|
    t.string   "UserID"
    t.string   "ProductID"
    t.integer  "Price"
    t.string   "Quantity"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "products", :primary_key => "ProductID", :force => true do |t|
    t.string   "ProductName"
    t.string   "ProductDesc"
    t.integer  "Price"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "FirstName"
    t.string   "LastName"
    t.string   "Password"
    t.string   "ShippingAddress"
    t.string   "City"
    t.string   "State"
    t.string   "Zip"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

end
