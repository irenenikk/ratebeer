class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :edit, :update, :destroy]

  def index
    @ratings = Rating.all
    @recent = Rating.recent
    @top_three_breweries = Rails.cache.fetch("brewery top 3", { expires_in: 3600}) { Brewery.top(3) }
    @top_three_beers = Rails.cache.fetch("beer top 3", { expires_in: 3600}) { Beer.top(3) }
    @top_three_styles = Rails.cache.fetch("style top 3", { expires_in: 3600}) { Style.top(3) }
    @most_active_users = Rails.cache.fetch("user top 3", { expires_in: 3600}) { User.top(3) }
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.create params.require(:rating).permit(:score, :beer_id)
    if @rating.save
      current_user.ratings << @rating
      redirect_to current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end

end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_rating
    @rating = Rating.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def rating_params
    params.require(:rating).permit(:score)
  end
