# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_13_161734) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "acts", force: :cascade do |t|
    t.integer "quantity"
    t.bigint "availability_id", null: false
    t.bigint "store_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "order_item_id"
    t.integer "state", default: 1
    t.boolean "preorder", default: false
    t.index ["availability_id"], name: "index_acts_on_availability_id"
    t.index ["order_item_id"], name: "index_acts_on_order_item_id"
    t.index ["store_id"], name: "index_acts_on_store_id"
  end

  create_table "availabilities", force: :cascade do |t|
    t.bigint "variant_id"
    t.bigint "size_id"
    t.bigint "store_id"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["size_id"], name: "index_availabilities_on_size_id"
    t.index ["store_id"], name: "index_availabilities_on_store_id"
    t.index ["variant_id", "size_id"], name: "index_availabilities_on_variant_id_and_size_id", unique: true
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
    t.text "desc"
    t.index ["category_id"], name: "index_category_translations_on_category_id"
    t.index ["locale"], name: "index_category_translations_on_locale"
  end

  create_table "certs", force: :cascade do |t|
    t.decimal "discount"
    t.integer "discount_type"
    t.integer "amount"
    t.string "code"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_certs_on_user_id"
  end

  create_table "collection_translations", force: :cascade do |t|
    t.bigint "collection_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.text "text"
    t.index ["collection_id"], name: "index_collection_translations_on_collection_id"
    t.index ["locale"], name: "index_collection_translations_on_locale"
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

  create_table "delivery_cities", force: :cascade do |t|
    t.string "title"
    t.integer "door"
    t.string "door_days"
    t.integer "storage"
    t.string "storage_days"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "identities", force: :cascade do |t|
    t.string "uid"
    t.string "provider"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_identities_on_user_id"
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

  create_table "kit_translations", force: :cascade do |t|
    t.bigint "kit_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["kit_id"], name: "index_kit_translations_on_kit_id"
    t.index ["locale"], name: "index_kit_translations_on_locale"
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
    t.boolean "latest", default: false
    t.integer "state", default: 0
    t.string "title"
    t.bigint "category_id"
    t.integer "weight", default: 0
    t.boolean "video_hide", default: false
    t.index ["category_id"], name: "index_kits_on_category_id"
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
    t.decimal "amount"
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
    t.text "address_old"
    t.string "payment_id"
    t.decimal "payment_amount"
    t.integer "delivery"
    t.bigint "delivery_city_id"
    t.integer "delivery_option"
    t.datetime "payed_at"
    t.string "phone"
    t.integer "promo"
    t.integer "gift"
    t.string "street"
    t.string "house"
    t.string "appartment"
    t.text "comment"
    t.string "city"
    t.string "country"
    t.bigint "user_address_id"
    t.decimal "amount"
    t.decimal "amount_delivery"
    t.integer "tracker_type"
    t.string "tracker_id"
    t.index ["delivery_city_id"], name: "index_orders_on_delivery_city_id"
    t.index ["user_address_id"], name: "index_orders_on_user_address_id"
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

  create_table "promo_translations", force: :cascade do |t|
    t.bigint "promo_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["locale"], name: "index_promo_translations_on_locale"
    t.index ["promo_id"], name: "index_promo_translations_on_promo_id"
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
    t.text "desc"
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
    t.bigint "theme_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "variant_id", null: false
    t.integer "weight", default: 0
    t.index ["theme_id"], name: "index_themables_on_theme_id"
    t.index ["variant_id"], name: "index_themables_on_variant_id"
  end

  create_table "theme_translations", force: :cascade do |t|
    t.bigint "theme_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "title"
    t.text "desc"
    t.index ["locale"], name: "index_theme_translations_on_locale"
    t.index ["theme_id"], name: "index_theme_translations_on_theme_id"
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

  create_table "user_addresses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "delivery_city_id"
    t.string "street"
    t.string "house"
    t.string "appartment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "city"
    t.string "country"
    t.integer "delivery_option"
    t.index ["delivery_city_id"], name: "index_user_addresses_on_delivery_city_id"
    t.index ["user_id"], name: "index_user_addresses_on_user_id"
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
    t.boolean "editor", default: false
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
    t.string "title"
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
    t.boolean "pinned", default: false
    t.text "comp"
    t.boolean "soon", default: false
    t.string "code"
    t.boolean "show", default: true
    t.boolean "premium"
    t.boolean "stayhome"
    t.boolean "morning"
    t.integer "quantity", default: 0, null: false
    t.integer "acts_count", default: 0, null: false
    t.integer "preorder", default: 0
    t.integer "preordered", default: 0
    t.boolean "linen", default: false
    t.boolean "spec", default: false
    t.integer "weight", default: 0
    t.boolean "video_hide", default: false
    t.index ["color_id"], name: "index_variants_on_color_id"
    t.index ["pinned"], name: "index_variants_on_pinned"
    t.index ["product_id", "color_id"], name: "index_variants_on_product_id_and_color_id", unique: true
    t.index ["product_id"], name: "index_variants_on_product_id"
    t.index ["state"], name: "index_variants_on_state"
  end

  create_table "wishlists", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "variant_id"
    t.index ["user_id"], name: "index_wishlists_on_user_id"
    t.index ["variant_id"], name: "index_wishlists_on_variant_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "acts", "availabilities"
  add_foreign_key "acts", "order_items"
  add_foreign_key "acts", "stores"
  add_foreign_key "availabilities", "sizes"
  add_foreign_key "availabilities", "stores"
  add_foreign_key "availabilities", "variants"
  add_foreign_key "carts", "sizes"
  add_foreign_key "carts", "users"
  add_foreign_key "carts", "variants"
  add_foreign_key "certs", "users"
  add_foreign_key "discounts", "users"
  add_foreign_key "identities", "users"
  add_foreign_key "kitables", "variants"
  add_foreign_key "kits", "categories"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "variants"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "sizes"
  add_foreign_key "order_items", "variants"
  add_foreign_key "orders", "delivery_cities"
  add_foreign_key "orders", "user_addresses"
  add_foreign_key "orders", "users"
  add_foreign_key "products", "categories"
  add_foreign_key "refunds", "orders"
  add_foreign_key "refunds", "users"
  add_foreign_key "similarables", "products"
  add_foreign_key "sizes", "sizes_groups"
  add_foreign_key "themables", "themes"
  add_foreign_key "themables", "variants"
  add_foreign_key "user_addresses", "delivery_cities"
  add_foreign_key "user_addresses", "users"
  add_foreign_key "variants", "colors"
  add_foreign_key "variants", "products"
  add_foreign_key "wishlists", "users"
  add_foreign_key "wishlists", "variants"
end
