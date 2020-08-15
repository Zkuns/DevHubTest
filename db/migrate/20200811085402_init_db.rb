class InitDb < ActiveRecord::Migration[6.0]
  def change
    create_table "combos" do |t|
      t.string   "name"
      t.decimal  "price", precision: 8, scale: 2
      t.text     "description"
      t.integer  "cut_off_week", default: 0
      t.time     "cut_off_time"
      t.timestamps
    end

    create_table "subscriptions" do |t|
      t.integer  "user_id", index:true
      t.integer  "combo_id", index: true
      t.integer  "status", default: 0
      t.timestamps
    end

    add_index "subscriptions", %w(user_id combo_id), name: "index_subscription_user_id_and_combo_id", using: :btree

    create_table "orders" do |t|
      t.integer  "user_id", index: true
      t.integer  "combo_id", index: true
      t.integer  "order_group_id", index: true
      t.integer  "subscription_id", index: true
      t.timestamps
    end

    add_index "orders", %w(user_id combo_id), name: "index_order_user_id_and_combo_id", using: :btree

    create_table "order_groups" do |t|
      t.integer  "combo_id", index: true
      t.datetime "start_at"
      t.datetime "end_at"
      t.timestamps
    end
  end
end
