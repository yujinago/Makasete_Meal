class RestaurantsController < ApplicationController
  before_action :ensure_current_user, only: [:show, :edit, :update, :destroy]
  
  require 'net/http'
  require 'uri'
  require 'json'
  
  def new
    @restaurant = Restaurant.new
    @restaurant_genres = RestaurantGenre.all
    
    # 大エリア
    large_area_results = []
    key = ENV['HotPepper_API_KEY']
    large_area_uri = URI.parse("http://webservice.recruit.co.jp/hotpepper/large_area/v1/?key=#{key}&format=json")
    large_area_response = Net::HTTP.get_response(large_area_uri)
    if large_area_response.code =="301"
      large_area_uri = URI.parse(large_area_response["location"])
    end
    large_area_json = Net::HTTP.get(large_area_uri)
    large_area_result_all = JSON.parse(large_area_json)
    large_area_result_all["results"]["large_area"].each do |large_area|
      code = large_area["code"]
      name = large_area["name"]
    
      large_area_result = { name => code }
      large_area_results << large_area_result
    end
    large_area_results_hash = large_area_results.reduce({}, :merge)
    @large_area_results = large_area_results_hash
    
  end
  
  def middle_area_select
    if request.xhr?
    # 中エリア
    middle_area_results = []
    large_area = params[:restaurant_large_area]
    key = ENV['HotPepper_API_KEY']
    middle_area_uri = URI.parse("http://webservice.recruit.co.jp/hotpepper/middle_area/v1/?key=#{key}&large_area=#{large_area}&format=json")
    middle_area_response = Net::HTTP.get_response(middle_area_uri)
    if middle_area_response.code =="301"
      middle_area_uri = URI.parse(middle_area_response["location"])
    end
    middle_area_json = Net::HTTP.get(middle_area_uri)
    middle_area_result_all = JSON.parse(middle_area_json)
    middle_area_result_all["results"]["middle_area"].each do |middle_area|
      code = middle_area["code"]
      name = middle_area["name"]
    
      middle_area_result = { name => code }
      middle_area_results << middle_area_result
    end
    middle_area_results_hash = middle_area_results.reduce({}, :merge)
    @middle_area_results = middle_area_results_hash
    
    render partial: 'restaurants/middle_area',locals: {middle_area_results: @middle_area_results}
    end
    
  end

  def confirm
    @restaurant_genres = RestaurantGenre.all
    results = []
    if params[:restaurant][:select_restaurant_genre_id] == "0"
      genre_code = params[:restaurant][:restaurant_genre_id]
      if genre_code.blank?
        genre_code = @restaurant_genres.offset( rand(@restaurant_genres.count) ).first.genre_code
      end
      large_area = params[:restaurant][:restaurant_large_area]
      middle_area = params[:restaurant][:restaurant_middle_area]
      if large_area.blank? || middle_area.blank?
        flash[:alert] = "場所を選択するか、完全におまかせを選択してください。"
        redirect_to new_restaurant_path
      end
      
    elsif params[:restaurant][:select_restaurant_genre_id] == "1"
      genre_code = @restaurant_genres.offset( rand(@restaurant_genres.count) ).first.genre_code
    end
    
      restaurant_genre = RestaurantGenre.find_by(genre_code: genre_code)
      
      key = ENV['HotPepper_API_KEY']
      uri = URI.parse("http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=#{key}&genre=#{genre_code}&large_area=#{large_area}&middle_area=#{middle_area}&format=json")
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
      @restaurant_large_area = result["large_area"]["code"]
      @restaurant_middle_area = result["middle_area"]["code"]
      @restaurant = Restaurant.new(result_hash)
    
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
    @restaurant_info = Restaurant.find_by(url: @restaurant['url'])
  end

  def index
    @restaurant_genres = RestaurantGenre.all
    if params[:genre_id]
      if params[:genre_id].blank?
        flash[:alert] = "ジャンルを選択してください"
        redirect_to restaurants_path
      else
        @restaurant_genre = RestaurantGenre.find(params[:genre_id])
        @genre_restaurant_all = @restaurant_genre.restaurants.where(user_id: current_user.id)
        restaurants = @restaurant_genre.restaurants.where(user_id: current_user.id)
      end
    elsif params[:user_id]
      favorites = RestaurantFavorite.where(user_id: current_user.id).pluck(:restaurant_id)
      @favorite_restaurant_all = Restaurant.where(id: favorites)
      restaurants = Restaurant.where(id: favorites)
    else
      @restaurant_all = current_user.restaurants.all
      restaurants = current_user.restaurants
    end
      
    restaurants = params[:latest] ? restaurants.latest : restaurants
    restaurants = params[:old] ? restaurants.old : restaurants
    restaurants = params[:star_count] ? restaurants.star_count : restaurants
    
    @restaurants = restaurants.page(params[:page])
  end

  def show
    @restaurant = current_user.restaurants.find(params[:id])
  end

  def edit
    @restaurant = current_user.restaurants.find(params[:id])
  end
  
  def update
    @restaurant = current_user.restaurants.find(params[:id])
    if @restaurant.update(restaurant_review_params)
      flash[:notice] = "お店のレビューを変更しました"
      redirect_to restaurant_path(@restaurant)
    else
      render "edit"
    end
  end
  
  def destroy
    @restaurant = current_user.restaurants.find(params[:id])
    @restaurant.destroy
    flash[:notice] = "お店を削除しました"
    redirect_to restaurants_path
  end
  
  private
  
  def restaurant_params
    params.require(:restaurant).permit(:user_id, :name, :url, :restaurant_genre_id, :address, :open_time, :legular_holiday)
  end
  
  def restaurant_review_params
    params.require(:restaurant).permit(:memo, :star)
  end
  
  def ensure_current_user
    if params[:id] == "confirm"
      flash[:alert] = "提案画面でのリロードは無効です。もう一度条件を選択し直してください。"
      redirect_to new_restaurant_path
    else
      restaurant = Restaurant.find_by(id: params[:id])
      if restaurant.nil? || current_user.id != restaurant.user_id
        flash[:alert] = "不正なアクセスです。"
        redirect_to restaurants_path
      end
    end
  end
    
end