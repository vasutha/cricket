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

ActiveRecord::Schema.define(:version => 20141024054432) do

  create_table "balls", :force => true do |t|
    t.integer  "over_id"
    t.integer  "player_id"
    t.boolean  "four",       :default => false
    t.boolean  "six",        :default => false
    t.boolean  "nb",         :default => false
    t.boolean  "wides",      :default => false
    t.boolean  "wicket",     :default => false
    t.string   "runs"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "battings", :force => true do |t|
    t.integer  "team_id"
    t.integer  "player_id"
    t.integer  "match_id"
    t.string   "dismissal_type"
    t.string   "dismissed_by"
    t.string   "order"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "bowlings", :force => true do |t|
    t.integer  "team_id"
    t.integer  "player_id"
    t.integer  "match_id"
    t.string   "order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "games", :force => true do |t|
    t.integer  "team_id"
    t.integer  "match_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "matches", :force => true do |t|
    t.integer  "team1"
    t.integer  "team2"
    t.integer  "bat_first"
    t.datetime "date"
    t.string   "mom"
    t.string   "place"
    t.integer  "team_won"
    t.integer  "toss_won"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "overs", :force => true do |t|
    t.integer  "team_id"
    t.integer  "player_id"
    t.integer  "match_id"
    t.string   "count"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "ballcount"
  end

  create_table "players", :force => true do |t|
    t.integer  "team_id"
    t.string   "player_name"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "team_name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tournaments", :force => true do |t|
    t.integer  "match_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
