json.extract! spot, :id, :name, :english_name, :category, :prefecture, :address, :address_in_english, :ssid, :url, :longitude, :latitude, :created_at, :updated_at
json.url spot_url(spot, format: :json)
