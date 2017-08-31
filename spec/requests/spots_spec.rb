require 'rails_helper'

RSpec.describe "Spots", type: :request do
  describe "GET /api/v1/spots" do

    before { @spot = FactoryGirl.create(:spot) }

    it "spots一覧の取得ができること" do

      get api_v1_spots_path

      # status code の確認
      expect(response).to have_http_status(200)

      # json
      json = JSON.parse(response.body)
      expect(json.size).to eq 5
      # check_json_contents(json, 4)

    end

    it "クエリパラメータを指定してレスポンスを得られること" do

      get api_v1_sopts_path, params: {radius: 1000, latitude: 35.681167, longitude: 139.767052, limit: 10}

      # status code
      expect(reponse).to have_http_status(200)

      # json
      json = JSON.parse(response.body)
      expect(json.size).to eq 5
      # check_json_contents(9)
    end

  end
end


# def check_json_contents(json, number)
#   (0..number).each do |i|
#     expect(json[i]"name"]).to eq Spot.all[i].name
#     expect(json[i]["address"]).to eq Spot.all[i].address
#   end
# end
