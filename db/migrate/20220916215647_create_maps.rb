class CreateMaps < ActiveRecord::Migration[6.1]
  def change
    create_table :maps do |t|
      t.string "address" # 住所
      t.float "latitude" # 緯度
      t.float "longitude" # 経度

      t.timestamps
    end
  end
end
