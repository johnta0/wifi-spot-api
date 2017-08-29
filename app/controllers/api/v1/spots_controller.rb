require "#{Rails.root}/app/controllers/application_controller.rb"

module Api
  module V1 class SpotsController < ApplicationController
      before_action :set_spot, only: [:show, :edit, :update, :destroy]


      # the method to search spots within r meters
      # GET /api/v1/spots/
      def index

        lat = params[:latitude].to_f
        lng = params[:longitude].to_f

        if not params[:radius].nil?
         radius = params[:radius].to_f # km -> m
        else
         radius = 0.5
        end

        # radiusメートル以内のスポットを検索して、jsonファイルにして表示
        render json: Spot.within(radius, :origin => [lat, lng])
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
