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

ActiveRecord::Schema.define(version: 20161221234536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "legislators", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "party"
    t.string   "state"
    t.string   "chamber"
    t.date     "term_start"
    t.date     "term_end"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.string   "contact_form_url"
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.string   "youtube_url"
    t.string   "fax"
    t.string   "photo_url"
    t.string   "gender"
    t.string   "votesmart_id"
    t.string   "office"
    t.date     "birthday"
    t.string   "bioguide_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "reps", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "party"
    t.string   "state"
    t.string   "chamber"
    t.date     "term_start"
    t.date     "term_end"
    t.string   "phone"
    t.string   "email"
    t.string   "website"
    t.string   "facebook_url"
    t.string   "twitter_url"
    t.string   "youtube_url"
    t.string   "fax"
    t.string   "contact_form_url"
    t.string   "photo_url"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

end
