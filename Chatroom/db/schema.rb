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

ActiveRecord::Schema.define(version: 2019_03_10_081936) do

  create_table "channels", force: :cascade do |t|
    t.text "name"
    t.integer "belongs_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "chat_message_id"
    t.integer "room_id"
    t.index ["chat_message_id"], name: "index_channels_on_chat_message_id"
    t.index ["room_id"], name: "index_channels_on_room_id"
  end

  create_table "chat_messages", force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "channel_id"
    t.index ["channel_id"], name: "index_chat_messages_on_channel_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "user_id1"
    t.integer "user_id2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "channel_id"
    t.index ["channel_id"], name: "index_rooms_on_channel_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
