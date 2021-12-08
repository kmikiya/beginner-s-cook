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

ActiveRecord::Schema.define(version: 2021_12_08_031134) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "comments", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "explanation_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "comment", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", null: false
    t.string "profile"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "profile_image_id"
    t.string "bg_image_id"
    t.index ["email"], name: "index_customers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_customers_on_reset_password_token", unique: true
  end

  create_table "explanations", force: :cascade do |t|
    t.integer "recipe_id", null: false
    t.text "explanation", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "process_image_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.integer "customer_id"
    t.integer "recipe_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "material_details", force: :cascade do |t|
    t.float "calorie"
    t.float "sugar"
    t.float "protein"
    t.float "lipids"
    t.float "dietary_fiber"
    t.float "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "amount"
    t.string "name"
    t.index ["name"], name: "index_material_details_on_name", unique: true
  end

  create_table "materials", force: :cascade do |t|
    t.integer "recipe_id"
    t.integer "material_detail_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "recipes", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.string "title", null: false
    t.integer "time", null: false
    t.string "comment", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reports", force: :cascade do |t|
    t.integer "customer_id", null: false
    t.integer "recipe_id", null: false
    t.string "impression", null: false
    t.float "evaluation", null: false
    t.string "image_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
