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

ActiveRecord::Schema.define(:version => 20100922052923) do

  create_table "questions", :force => true do |t|
    t.integer  "survey_id"
    t.text     "content"
    t.text     "response_type"
    t.integer  "order"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", :force => true do |t|
    t.string   "name"
    t.string   "intro"
    t.string   "thank_you"
    t.datetime "pub_date"
    t.datetime "end_date"
    t.string   "pub_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
