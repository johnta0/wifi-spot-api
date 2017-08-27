require 'csv'

CSV.foreach('db/jta_free_wifi.csv') do |row|
    Spot.create(:name => row[1], :english_name => row[2], :category => row[4], :prefecture => row[7], :address => row[8], :address_in_english => row[9], :ssid => row[12], :url => row[18], :longitude => row[19], :latitude => row[20])
end
