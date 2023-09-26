class RestaurantFavoritesController < ApplicationController
  
  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    restaurant_favorite = current_user.restaurant_favorites.new(restaurant_id: @restaurant.id)
    restaurant_favorite.save
  end
  
  def destroy
    @restaurant = Restaurant.find(params[:restaurant_id])
    restaurant_favorite = current_user.restaurant_favorites.find_by(restaurant_id: @restaurant.id)
    restaurant_favorite.destroy
  end
  
end
