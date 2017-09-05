require "#{Rails.root}/app/controllers/application_controller.rb"
require "geokit-rails"

module Api
  module V1 class SpotsController < ApplicationController
      before_action :set_spot, only: [:show, :edit, :update, :destroy]


      # GET /api/v1/spots/
      def index

        # 緯度経度パラメータ
        if params[:latitude].nil? or params[:longitude].nil?
          @spots = Spot.all
        else
          lat = params[:latitude].to_f
          lng = params[:longitude].to_f

          latlng = [lat, lng]

          # radiusパラメータ
          unless params[:radius].nil?
           radius = params[:radius].to_i # km -> m
          else
           radius = 500
          end
        end

        # limitパラメータ
        unless (params[:limit].nil? or params[:limit].to_i < 1)
          limit = params[:limit].to_i
        else
          limit = 5
        end

        @spots = Spot.sort_by_distance(latlng, radius, limit)

        # languageパラメータ
        unless params[:lang].nil?
          lang = params[:lang]
        else
          lang = 'ja'
        end

        if lang == 'ja'
          @spots = @spots.map do |spot|
            spot = {
              name: spot.name,
              address: spot.address,
              distance_in_meters: spot.distance_from(latlng, :units => :meters),
              ssid: spot.ssid,
              url: spot.url
            }
          end
        elsif lang = 'en'
          @spots = @spots.map do |spot|
            spot = {
              name: spot.english_name,
              address: spot.address_in_english,
              distance_in_miles: spot.distance_from(latlng, :units => :miles),
              ssid: spot.ssid,
              url: spot.url
            }
          end
        end

        render json: @spots
      end

      # GET /api/v1/spots/search?word=xxx
      def search

        if params[:word].nil?
          return not_found
        end

        word = params[:word]

        if params[:limit].nil?
          limit = 5
        else
          limit = params[:limit].to_i
        end

        @spots = Spot.search(word, limit)

        @spots = @spots.map do |spot|
          spot = {
            name: spot.name,
            address: spot.address,
            ssid: spot.ssid,
            url: spot.url
          }
        end

        render json: @spots
      end

      # GET /api/v1/spots/1
      def show
        render json: Spot.find(params[:id])
      end
      # POST /api/v1/spots
      def create
        @spot = Spot.new(spot_params)
        if @spot.save
          render json: @spot
        else
          render json: @spot.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/spots/1
      def update
        if @spot.update(spot_params)
          render json: @spot
        else
          render json: @spot.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/spots/1
      def destroy
        @spot.destroy
        head :no_content
      end

      def distance
        500
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_spot
        @spot = Spot.find(params[:id])
      end

      # Never trust parameters from the scary internet, only allow the white list through.
      def spot_params
        params.require(:spot).permit(:name, :age)
      end

      def not_found
        raise ActionController::RoutingError.new('Not Found')
      end
    end
  end
end
