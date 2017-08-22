class CreateSpots < ActiveRecord::Migration[5.1]
  def change
    create_table :spots do |t|
      t.string :name
      t.string :english_name
      t.string :category
      t.string :prefecture
      t.string :address
      t.string :address_in_english
      t.string :ssid
      t.string :url
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
