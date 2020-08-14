class FavoritesController < ApplicationController
  before_action :logged_in_user

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    current_user.favorite(@restaurant)
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end

  def index
    @favorites = current_user.favorites
  end

  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    current_user.favorites.find_by(restaurant_id: @restaurant.id).destroy
    respond_to do |format|
      format.html { redirect_to request.referrer || root_url }
      format.js
    end
  end
end