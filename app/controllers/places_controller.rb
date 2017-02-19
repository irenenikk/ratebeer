class PlacesController < ApplicationController
  before_action :set_place, only: [:show, :edit, :update, :destroy]

  def index
  end

  def search
    @places = BeermappingApi.fetch_places_in(params[:city])
    @city = (params[:city])
    @weather = WeatherApi.weather_in(params[:city])
    if @places.empty?
      redirect_to places_path, notice: "No locations in #{params[:city]}"
    else
      render :index
    end
  end

  def show
  end

  private

  def set_place
    @place = BeermappingApi.fetch_place_by_id(params[:id])
  end

end
