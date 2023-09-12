class RestaurantGenresController < ApplicationController
  require 'net/http'
  require 'uri'
  require 'json'
  def create
    @restaurant_genres = []
    key = ENV['HotPepper_API_KEY']
    uri = URI.parse("http://webservice.recruit.co.jp/hotpepper/genre/v1/?key=#{key}&format=json")
    json = Net::HTTP.get(uri)
    results = JSON.parse(json)
    results.each do |result|
      restaurant_genre = RestaurantGenre.new(eat(result))
      @restaurant_genres << restaurant_genre
    end
    @restaurant_genres.each do |restaurant_genre|
      unless RestaurantGenre.exists?(genre_code: restaurant_genre.genre_code)
        restaurant_genre.save
      end
    end
    redirect_to new_restaurant_path

  end
  
  private
  
  def eat(result)
    name = result["name"]
    genre_code = result["code"]
    {
      name: name,
      genre_code: genre_code
    }
  end
  
end
