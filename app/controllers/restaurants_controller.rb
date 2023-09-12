class RestaurantsController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  
  def new
    @restaurant = Restaurant.new
    @restaurant_genres = RestaurantGenre.all
  end

  def confirm
    @restaurant_genres = RestaurantGenre.all
    results = []
    if params[:restaurant][:select_restaurant_genre_id] == "0"
      genre_code = params[:restaurant][:restaurant_genre_id]
    elsif params[:restaurant][:select_restaurant_genre_id] == "1"
      genre_code = @restaurant_genres.offset( rand(@restaurant_genres.count) ).first.genre_code
    end
    if genre_code.blank?
      redirect_to new_restaurant_path, notice: "条件を選択するか、完全におまかせを選択してください。"
    else
      restaurant_genre = RestaurantGenre.find_by(genre_code: genre_code)
      
      key = ENV['HotPepper_API_KEY']
      uri = URI.parse("http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=#{key}&genre=#{genre_code}&format=json")
      response = Net::HTTP.get_response(uri)
      if response.code =="301"
        uri = URI.parse(response["location"])
      end
      json = Net::HTTP.get(uri)
      result_all = JSON.parse(json)
      result_all["results"]["shop"].each {|n| results << n}
      
      result = results.sample
      result_hash = {
        user_id: current_user.id,
        restaurant_genre_id: restaurant_genre.id,
        name: result["name"],
        url: result["urls"]["pc"],
        address: result["address"],
        open_time: result["open"],
        legular_holiday: result["close"]
      }
      @restaurant_image = result["photo"]["pc"]["l"]
      @restaurant = Restaurant.new(result_hash)
    end
  end
  
  def create
    @restaurant = Restaurant.new(restaurant_params)
    require 'open-uri'
    restaurant_image = params[:restaurant][:restaurant_image]
    file = URI.open(restaurant_image)
    file_name = File.basename(URI.parse(restaurant_image).path)
    @restaurant.restaurant_image.attach(io: file, filename: file_name)
    @restaurant.save
    session[:last_saved_info] = @restaurant
    redirect_to complete_restaurants_path
  end
  
  def complete
    @restaurant = session[:last_saved_info]
    @restaurant_genre = RestaurantGenre.find_by(id: @restaurant['restaurant_genre_id'])
  end

  def index
  end

  def show
  end

  def edit
  end
  
  def update
    
  end
  
  def destory
    
  end
  
  private
  
  def recipe_params
    params.require(:restaurant).permit(:user_id, :name, :url, :restaurant_genre_id, :address, :open_time, :legular_holiday)
  end
  
end
