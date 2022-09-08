class CreateReserves < ActiveRecord::Migration[6.1]
  def change
    create_table :reserves do |t|
      t.integer :customer_id
      t.string :name

      t.timestamps
    end
  end
end
