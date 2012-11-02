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

ActiveRecord::Schema.define(:version => 20121030100030) do

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                  :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_ckeditor_assetable_type"

  create_table "consumers", :force => true do |t|
    t.string  "description"
    t.boolean "deleted"
    t.integer "house_id"
    t.string  "flat"
    t.string  "entrance"
    t.integer "floor"
    t.float   "calc_area"
    t.float   "heat_area"
    t.integer "numbrsdn"
    t.integer "numbmgst"
    t.integer "letter"
    t.string  "code"
  end

  add_index "consumers", ["house_id"], :name => "index_consumers_on_house_id"

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.text     "message"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "contractors", :force => true do |t|
    t.string  "description"
    t.boolean "deleted"
    t.string  "full_description"
    t.string  "zkpo"
    t.string  "inn"
    t.string  "ncert"
    t.string  "leg_address"
    t.string  "address"
    t.string  "phone"
    t.string  "bnkcc"
  end

  create_table "conversations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "service_provider_id"
    t.string   "token"
    t.string   "subject"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  create_table "districts", :force => true do |t|
    t.string  "name"
    t.boolean "deleted"
  end

  create_table "firms", :force => true do |t|
    t.string  "description"
    t.boolean "deleted"
    t.string  "full_description"
    t.integer "zheo_id"
    t.string  "bnkcc"
    t.integer "street_id"
    t.boolean "zkpo"
    t.string  "inn"
    t.string  "ncert"
    t.string  "leg_address"
    t.string  "address"
    t.string  "phone"
    t.string  "leg_phone"
    t.string  "fax"
    t.string  "phone_service"
  end

  add_index "firms", ["street_id"], :name => "index_firms_on_street_id"
  add_index "firms", ["zheo_id"], :name => "index_firms_on_zheo_id"

  create_table "forem_categories", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "slug"
  end

  add_index "forem_categories", ["slug"], :name => "index_forem_categories_on_slug", :unique => true

  create_table "forem_forums", :force => true do |t|
    t.string  "title"
    t.text    "description"
    t.integer "category_id"
    t.integer "views_count", :default => 0
    t.string  "slug"
  end

  add_index "forem_forums", ["slug"], :name => "index_forem_forums_on_slug", :unique => true

  create_table "forem_groups", :force => true do |t|
    t.string "name"
  end

  add_index "forem_groups", ["name"], :name => "index_forem_groups_on_name"

  create_table "forem_memberships", :force => true do |t|
    t.integer "group_id"
    t.integer "member_id"
  end

  add_index "forem_memberships", ["group_id"], :name => "index_forem_memberships_on_group_id"

  create_table "forem_moderator_groups", :force => true do |t|
    t.integer "forum_id"
    t.integer "group_id"
  end

  add_index "forem_moderator_groups", ["forum_id"], :name => "index_forem_moderator_groups_on_forum_id"

  create_table "forem_posts", :force => true do |t|
    t.integer  "topic_id"
    t.text     "text"
    t.integer  "user_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "reply_to_id"
    t.string   "state",       :default => "pending_review"
    t.boolean  "notified",    :default => false
  end

  add_index "forem_posts", ["reply_to_id"], :name => "index_forem_posts_on_reply_to_id"
  add_index "forem_posts", ["state"], :name => "index_forem_posts_on_state"
  add_index "forem_posts", ["topic_id"], :name => "index_forem_posts_on_topic_id"
  add_index "forem_posts", ["user_id"], :name => "index_forem_posts_on_user_id"

  create_table "forem_subscriptions", :force => true do |t|
    t.integer "subscriber_id"
    t.integer "topic_id"
  end

  create_table "forem_topics", :force => true do |t|
    t.integer  "forum_id"
    t.integer  "user_id"
    t.string   "subject"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.boolean  "locked",       :default => false,            :null => false
    t.boolean  "pinned",       :default => false
    t.boolean  "hidden",       :default => false
    t.datetime "last_post_at"
    t.string   "state",        :default => "pending_review"
    t.integer  "views_count",  :default => 0
    t.string   "slug"
  end

  add_index "forem_topics", ["forum_id"], :name => "index_forem_topics_on_forum_id"
  add_index "forem_topics", ["slug"], :name => "index_forem_topics_on_slug", :unique => true
  add_index "forem_topics", ["state"], :name => "index_forem_topics_on_state"
  add_index "forem_topics", ["user_id"], :name => "index_forem_topics_on_user_id"

  create_table "forem_views", :force => true do |t|
    t.integer  "user_id"
    t.integer  "viewable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "count",             :default => 0
    t.string   "viewable_type"
    t.datetime "current_viewed_at"
    t.datetime "past_viewed_at"
  end

  add_index "forem_views", ["updated_at"], :name => "index_forem_views_on_updated_at"
  add_index "forem_views", ["user_id"], :name => "index_forem_views_on_user_id"
  add_index "forem_views", ["viewable_id"], :name => "index_forem_views_on_topic_id"

  create_table "houses", :force => true do |t|
    t.string  "description"
    t.boolean "deleted"
    t.integer "firm_id"
    t.integer "street_id"
    t.string  "number_code"
    t.string  "letter"
  end

  add_index "houses", ["firm_id"], :name => "index_houses_on_firm_id"
  add_index "houses", ["street_id"], :name => "index_houses_on_street_id"

  create_table "messages", :force => true do |t|
    t.integer  "conversation_id"
    t.text     "body"
    t.string   "from"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "page_parts", :force => true do |t|
    t.string "identifier"
    t.text   "content"
    t.string "format",     :default => "html"
  end

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "seo_title"
    t.string   "string"
    t.text     "seo_keywords"
    t.text     "seo_description"
    t.string   "identifier"
    t.boolean  "permanent",       :default => false
  end

  create_table "payment_terminals", :force => true do |t|
    t.integer  "code"
    t.string   "name"
    t.string   "address"
    t.string   "phone"
    t.string   "bank"
    t.string   "email"
    t.string   "payment_type"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "type"
  end

  add_index "payment_terminals", ["code"], :name => "index_payment_terminals_on_code"
  add_index "payment_terminals", ["name"], :name => "index_payment_terminals_on_name"

  create_table "post_categories", :force => true do |t|
    t.string "name", :null => false
  end

  create_table "posts", :force => true do |t|
    t.integer  "post_category_id"
    t.string   "title"
    t.text     "description"
    t.text     "content"
    t.boolean  "published",        :default => false
    t.string   "posted_by"
    t.datetime "created_at"
    t.string   "preview"
    t.string   "links"
  end

  add_index "posts", ["post_category_id"], :name => "index_posts_on_post_category_id"

  create_table "responsible_persons", :force => true do |t|
    t.integer  "service_provider_id"
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "incumbency"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
  end

  add_index "responsible_persons", ["service_provider_id"], :name => "index_responsible_persons_on_service_provider_id"

  create_table "roles", :force => true do |t|
    t.string "name"
  end

  create_table "service_providers", :force => true do |t|
    t.integer  "service_id"
    t.integer  "house_id"
    t.integer  "responsible_person_id"
    t.integer  "code"
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",            :null => false
    t.datetime "updated_at",            :null => false
    t.string   "phone"
    t.string   "address"
    t.string   "district"
  end

  add_index "service_providers", ["house_id"], :name => "index_service_providers_on_house_id"
  add_index "service_providers", ["responsible_person_id"], :name => "index_service_providers_on_responsible_person_id"
  add_index "service_providers", ["service_id"], :name => "index_service_providers_on_service_id"

  create_table "services", :force => true do |t|
    t.string  "description"
    t.boolean "deleted"
    t.integer "element"
    t.string  "uom"
    t.string  "label"
  end

  create_table "simple_captcha_data", :force => true do |t|
    t.string   "key",        :limit => 40
    t.string   "value",      :limit => 6
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "simple_captcha_data", ["key"], :name => "idx_key"

  create_table "streets", :force => true do |t|
    t.string  "name"
    t.boolean "deleted"
  end

  create_table "user_activities", :force => true do |t|
    t.string   "activity"
    t.integer  "user_id"
    t.string   "ip"
    t.string   "params"
    t.datetime "created_at"
  end

  add_index "user_activities", ["user_id"], :name => "index_user_activities_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "identifier"
    t.string   "name",                   :default => "",         :null => false
    t.string   "surname",                :default => "",         :null => false
    t.string   "email",                  :default => "",         :null => false
    t.string   "encrypted_password",     :default => "",         :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                                     :null => false
    t.datetime "updated_at",                                     :null => false
    t.boolean  "forem_admin",            :default => false
    t.string   "forem_state",            :default => "approved"
    t.boolean  "forem_auto_subscribe",   :default => false
    t.integer  "role_id",                :default => 3
    t.boolean  "blocked",                :default => false
    t.string   "avatar"
    t.string   "nickname"
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["identifier"], :name => "index_users_on_identifier"
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["role_id"], :name => "index_users_on_role_id"
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
