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

ActiveRecord::Schema.define(:version => 20100925230039) do

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.string   "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "survey_id"
    t.text     "content"
    t.text     "response_type"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipients", :force => true do |t|
    t.string   "email"
    t.boolean  "no_email",   :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "secret_key"
  end

  create_table "recipients_surveys", :id => false, :force => true do |t|
    t.integer "recipient_id"
    t.integer "survey_id"
  end

  add_index "recipients_surveys", ["recipient_id"], :name => "index_recipients_surveys_on_recipient_id"
  add_index "recipients_surveys", ["survey_id"], :name => "index_recipients_surveys_on_survey_id"

  create_table "surveys", :force => true do |t|
    t.string   "name"
    t.string   "intro"
    t.string   "thank_you"
    t.datetime "pub_date"
    t.datetime "end_date"
    t.string   "pub_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "owner_id"
  end

  add_index "surveys", ["owner_id"], :name => "index_surveys_on_owner_id"

  create_table "surveys_users", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "survey_id"
  end

  add_index "surveys_users", ["survey_id"], :name => "index_users_surveys_on_survey_id"
  add_index "surveys_users", ["user_id"], :name => "index_users_surveys_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.boolean  "is_admin"
    t.string   "pub_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
