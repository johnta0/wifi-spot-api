require 'rails_helper'


## 今回のAPIではAPIで新たにレコードを追加することはないので、validationのテストは省略する。

## Spot.sort_by_distance と Spot.search のテスト
describe Spot, :type => :model do
  it 'sort_by_distance method works fine' do

    latlng = [35.6815, 139.7654]
    radius = 10000
    limit = 10
    answer = []
    ## rails console -e test で確認した順番
    4.times do
      answer.push("東京駅")
    end
    4.times do
      answer.push("神田駅")
    end
    2.times do
      answer.push("秋葉原駅")
    end

    sorted_spots = Spot.sort_by_distance(latlng, radius, limit)

    sorted_spots.each_with_index do |spot, i|
      expect(spot.name).to eq answer[i]
    end

  end

  it 'search method returns spots whose address includes the search word' do

    # "品川" で検索
    word = "千代田"
    limit = 5
    result = Spot.search(word, limit)

    # 数がlimit通りか
    expect(result.count).to eq limit

    # 検索結果の住所が「千代田」を含むかどうか
    result.each do |spot|
      expect(spot.address).to include(word)
    end

  end
end
