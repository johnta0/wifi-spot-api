require 'rails_helper'

RSpec.describe "Spots", type: :request do

  describe "GET /api/v1/spots" do

    it "spots一覧の取得ができること" do

      get '/api/v1/spots'

      # status code の確認
      expect(response).to have_http_status(200)

      # json
      json = JSON.parse(response.body)
      expect(json.size).to eq 5

    end

  end

  describe "GET /api/v1/spots?(パラメータ指定)" do

    before do
      @lat = 35.681167, @lng = 139.767052, @radius = 1000

      get '/api/v1/spots', params: {radius: 1000, latitude: 35.681167, longitude: 139.767052, limit: 3}
      @json_by_params = JSON.parse(response.body)
    end

    it "クエリパラメータを指定してレスポンスを得られること" do

      # status code
      expect(response).to have_http_status(200)

    end

    it "limit通りの数のjsonが返ってきてること" do
     expect(@json_by_params.size).to eq 3
    end

    it "nameが正しいこと" do
      expect(@json_by_params[1]["name"].to eq Spot.sort_by_distance(@lat, @lng, @radius).limit(3)[1]["name"])
    end

    it "addressが正しいこと" do
      expect(@json_by_params[1]["address"].to eq Spot.sort_by_distance(@lat, @lng, @radius).limit(3)[1]["address"])
    end

    it "distanceが正しいこと" do
      expect(@json_by_params[1]["distance"].to eq Spot.sort_by_distance(@lat, @lng, @radius).limit(3)[1].distance_from([@lat, @lng], :units=>:meters))
    end

  end

  describe 'GET /api/v1/spots/:id' do

    before do
      get '/api/v1/spots/5'
      @json_by_id = JSON.parse(response.body)
    end

    it "idで指定したスポットの情報を得られること" do
      expect(response).to have_http_status(200)
    end

    it "idが正しいこと" do
      expect(@json_by_id["id"]).to eq 5
    end

  end



end


# def check_json_contents(json, number)
#   (0..number).each do |i|
#     expect(json[i]"name"]).to eq Spot.all[i].name
#     expect(json[i]["address"]).to eq Spot.all[i].address
#   end
# end
