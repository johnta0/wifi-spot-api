require "#{Rails.root}/app/controllers/application_controller.rb"
require "geokit-rails"

module Api
  module V1 class SpotsController < ApplicationController
      before_action :set_spot, only: [:show, :edit, :update, :destroy]


      # GET /api/v1/spots/
      def index

        # 緯度経度指定しない場合
        if params[:latitude].nil? or params[:longitude].nil?
          @spots = Spot.all
        # 緯度経度指定した場合
        else
          lat = params[:latitude].to_f
          lng = params[:longitude].to_f

          # radiusパラメータ
          unless params[:radius].nil?
           radius = params[:radius].to_i # km -> m
          else
           radius = 500
          end

          # :origin から近い順に並び替え
          @spots = Spot.within(radius, :origin => [lat, lng]).by_distance(:origin => [lat, lng])
        end

        # limitパラメータ
        unless params[:limit].nil?
          limit = params[:limit].to_i
        else
          limit = 5
        end
        # limitパラメータがwifiスポットのヒット件数より大きい場合の処理
        if limit > @spots.count
          limit = @spots.count
        end
        @spots = @spots.limit(limit)

        #### jsonレスポンスに distance を含めるための処理を書く
        @spots = @spots.map do |spot|
          spot = {
            name: spot.name,
            address: spot.address,
            distance: spot.distance_from([lat, lng], :units => :meters)
          }
        end

        # radiusメートル以内のスポットを検索して、jsonファイルにして表示
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
      end
  end
end
