require 'rails_helper'

RSpec.describe "Spots", type: :request do
  describe "GET /api/v1/spots" do
    
    it "spots一覧の取得ができること" do
      get spots_path
      # status code の確認
      expect(response).to have_http_status(200)
      # JSON
      json = JSON.parse(response.body)
      expect(json.size).to eq 5
      (0..4).each do |i|
        expect(json[i]["name"]).to eq Spot.all[i].name
        expect(json[i]["address"]).to eq Spot.all[i].address
        # expect(json[i]["distance"]).to eq 
      end

    end
  end
end
