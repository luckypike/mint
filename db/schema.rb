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

ActiveRecord::Schema.define(version: 2019_09_12_145727) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "availabilities", force: :cascade do |t|
    t.bigint "variant_id"
    t.bigint "size_id"
    t.bigint "store_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["size_id"], name: "index_availabilities_on_size_id"
    t.index ["store_id"], name: "index_availabilities_on_store_id"
    t.index ["variant_id"], name: "index_availabilities_on_variant_id"
  end

  create_table "carts", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "variant_id"
    t.integer "quantity", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "size_id"
    t.index ["size_id"], name: "index_carts_on_size_id"
    t.index ["user_id"], name: "index_carts_on_user_id"
    t.index ["variant_id"], name: "index_carts_on_variant_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.bigint "parent_category_id"
    t.integer "state", default: 0
    t.integer "weight", default: 0
    t.boolean "empty", default: false
    t.integer "variants_counter"
    t.boolean "front"
    t.index ["parent_category_id"], name: "index_categories_on_parent_category_id"
  end

  create_table "category_translations", force: :cascade do |t|
    t.bigint "category_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["category_id"], name: "index_category_translations_on_category_id"
    t.index ["locale"], name: "index_category_translations_on_locale"
  end

  create_table "collections", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "v"
    t.integer "weight", default: 0
    t.string "desc"
    t.index ["slug"], name: "index_collections_on_slug", unique: true
  end

  create_table "color_translations", force: :cascade do |t|
    t.bigint "color_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["color_id"], name: "index_color_translations_on_color_id"
    t.index ["locale"], name: "index_color_translations_on_locale"
  end

  create_table "colors", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.text "desc"
    t.bigint "parent_color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.string "image"
    t.index ["parent_color_id"], name: "index_colors_on_parent_color_id"
    t.index ["slug"], name: "index_colors_on_slug", unique: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "discounts", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "phone"
    t.float "size"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_discounts_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.string "photo"
    t.string "imagable_type"
    t.bigint "imagable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "uuid"
    t.integer "weight", default: 0
    t.integer "height"
    t.integer "width"
    t.boolean "favourite", default: false
    t.index ["imagable_type", "imagable_id"], name: "index_images_on_imagable_type_and_imagable_id"
  end

  create_table "kitables", force: :cascade do |t|
    t.bigint "kit_id"
    t.bigint "product_id"
    t.bigint "variant_id"
    t.index ["kit_id"], name: "index_kitables_on_kit_id"
    t.index ["product_id"], name: "index_kitables_on_product_id"
    t.index ["variant_id"], name: "index_kitables_on_variant_id"
  end

  create_table "kits", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "theme_id"
    t.boolean "latest", default: false
    t.integer "state", default: 0
    t.string "title"
    t.index ["theme_id"], name: "index_kits_on_theme_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "variant_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
    t.index ["variant_id"], name: "index_notifications_on_variant_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id"
    t.bigint "variant_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "price"
    t.bigint "size_id"
    t.integer "refund_id"
    t.boolean "repayment", default: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["size_id"], name: "index_order_items_on_size_id"
    t.index ["variant_id"], name: "index_order_items_on_variant_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "state", default: 0
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "address"
    t.string "payment_id"
    t.decimal "payment_amount"
    t.boolean "delivery"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_translations", force: :cascade do |t|
    t.bigint "product_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["locale"], name: "index_product_translations_on_locale"
    t.index ["product_id"], name: "index_product_translations_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.bigint "category_id"
    t.decimal "price"
    t.text "desc"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "colors", array: true
    t.bigint "kind_id"
    t.integer "state_manual", default: 0
    t.string "title"
    t.boolean "sale", default: false
    t.boolean "latest", default: false
    t.decimal "price_last"
    t.text "comp"
    t.integer "brand"
    t.boolean "state_auto", default: false
    t.boolean "trash", default: false
    t.boolean "pinned", default: false
    t.index ["category_id"], name: "index_products_on_category_id"
    t.index ["colors"], name: "index_products_on_colors", using: :gin
    t.index ["kind_id"], name: "index_products_on_kind_id"
  end

  create_table "promos", force: :cascade do |t|
    t.string "title"
    t.string "link"
    t.boolean "front"
    t.boolean "popup"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "refunds", force: :cascade do |t|
    t.integer "state"
    t.integer "reason"
    t.text "detail"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id"
    t.bigint "order_id"
    t.index ["order_id"], name: "index_refunds_on_order_id"
    t.index ["user_id"], name: "index_refunds_on_user_id"
  end

  create_table "similarables", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "similar_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_similarables_on_product_id"
    t.index ["similar_product_id"], name: "index_similarables_on_similar_product_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.string "size"
    t.bigint "sizes_group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weight", default: 0
    t.index ["sizes_group_id"], name: "index_sizes_on_sizes_group_id"
  end

  create_table "sizes_groups", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slide_translations", force: :cascade do |t|
    t.bigint "slide_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["locale"], name: "index_slide_translations_on_locale"
    t.index ["slide_id"], name: "index_slide_translations_on_slide_id"
  end

  create_table "slides", force: :cascade do |t|
    t.string "name"
    t.string "link"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "link_name"
    t.integer "weight"
    t.integer "left_offset"
    t.integer "top_offset"
    t.integer "logo", default: 0
  end

  create_table "stores", force: :cascade do |t|
    t.string "title"
    t.text "address"
  end

  create_table "themables", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "theme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_themables_on_product_id"
    t.index ["theme_id"], name: "index_themables_on_theme_id"
  end

  create_table "themes", force: :cascade do |t|
    t.string "title"
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "desc"
    t.string "title_long"
    t.integer "weight", default: 0
    t.integer "state", default: 0
    t.string "image"
    t.datetime "recency"
    t.index ["slug"], name: "index_themes_on_slug", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "remember_token"
    t.string "phone"
    t.string "name"
    t.integer "code"
    t.datetime "code_last"
    t.string "sname"
    t.integer "state", default: 0
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "variant_translations", force: :cascade do |t|
    t.bigint "variant_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "desc"
    t.text "comp"
    t.index ["locale"], name: "index_variant_translations_on_locale"
    t.index ["variant_id"], name: "index_variant_translations_on_variant_id"
  end

  create_table "variants", force: :cascade do |t|
    t.bigint "product_id"
    t.bigint "color_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "out_of_stock", default: false
    t.integer "state"
    t.jsonb "sizes_cache"
    t.text "desc"
    t.decimal "price"
    t.decimal "price_last"
    t.boolean "sale", default: false
    t.boolean "latest", default: false
    t.boolean "pinned", default: false
    t.text "comp"
    t.boolean "soon", default: false
    t.string "code"
    t.boolean "last", default: false
    t.boolean "show", default: true
    t.index ["color_id"], name: "index_variants_on_color_id"
    t.index ["product_id", "color_id"], name: "index_variants_on_product_id_and_color_id", unique: true
    t.index ["product_id"], name: "index_variants_on_product_id"
  end

  create_table "wishlists", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "variant_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
    t.index ["variant_id"], name: "index_wishlists_on_variant_id"
  end

  add_foreign_key "availabilities", "sizes"
  add_foreign_key "availabilities", "stores"
  add_foreign_key "availabilities", "variants"
  add_foreign_key "carts", "sizes"
  add_foreign_key "carts", "users"
  add_foreign_key "carts", "variants"
  add_foreign_key "discounts", "users"
  add_foreign_key "kitables", "variants"
  add_foreign_key "kits", "themes"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "variants"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "sizes"
  add_foreign_key "order_items", "variants"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "refunds", "orders"
  add_foreign_key "refunds", "users"
  add_foreign_key "similarables", "products"
  add_foreign_key "sizes", "sizes_groups"
  add_foreign_key "themables", "products"
  add_foreign_key "themables", "themes"
  add_foreign_key "variants", "colors"
  add_foreign_key "variants", "products"
  add_foreign_key "wishlists", "users"
  add_foreign_key "wishlists", "variants"
end
