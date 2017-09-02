require 'rails_helper'

RSpec.describe "Spots", type: :request do

  describe "GET /api/v1/spots" do

    before do
      get api_v1_spots_path
      @json = JSON.parse(response.body)
    end

    it "should be status 200" do
      expect(response).to have_http_status(200)
    end

    it "returns json whose size is 5" do
      expect(@json.size).to eq 5
    end

  end

  describe "GET /api/v1/spots?(パラメータ指定)" do

    before do
      # # テストするスポット
      # @lat = 35.681167, @lng = 139.767052, @latlng = [@lat, @lng], @radius = 1000, @limit =
      # @spot_to_test = Spot.within(@radius, :origin => @latlng).by_distance(:origin => @latlng).limit(@limit)[1]

      get '/api/v1/spots', params: {radius: "1000", latitude: "35.681167", longitude: "139.767052", limit: "1"}
      @json_by_params = JSON.parse(response.body)
    end

    it "returns response with status 200" do
      expect(response).to have_http_status(200)
    end

    it "returns accurate json data" do
      expect(@json_by_params.size).to eq 1
      expect(@json_by_params[0]["name"]).to eq "東京駅"
      expect(@json_by_params[0]["address"]).to eq "千代田区丸の内1丁目"
      expect(@json_by_params[0]["distance"]).to eq 153.13775471537662
    end

  end

  describe 'GET /api/v1/spots/:id' do

    before do
      get '/api/v1/spots/5'
      @json_by_id = JSON.parse(response.body)
    end

    it "return status 200" do
      expect(response).to have_http_status(200)
    end

    it "returns json with proper id" do
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
