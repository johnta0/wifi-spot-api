require 'csv'

CSV.foreach('db/production.csv') do |row|

    # データ挿入
    Spot.create(:name => row[1], :english_name => row[2], :category => row[4], :prefecture => row[7], :address => row[8], :address_in_english => row[9], :ssid => row[12], :url => row[17], :lat => row[18], :lng => row[19])

end

