class CreateReserves < ActiveRecord::Migration[6.1]
  def change
    create_table :reserves do |t|
      t.date "day", null: false
      t.string "time", null: false
      t.bigint "customer_id", null: false
      t.datetime "start_time", null: false
      t.index ["customer_id"], name: "index_reserve_on_customer_id"

      t.timestamps
    end
  end
end
