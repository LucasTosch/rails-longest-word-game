require "open-uri"

class GamesController < ApplicationController

  def new
    letters = ("a".."z").to_a
    @letters = Array.new(10) { letters.sample }
  end

  def score
    @letters = params[:letters]
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    verify_words = JSON.parse(URI.parse(url).read)
    if params[:word].chars.all? { |letter| @letters.to_s.include?(letter) } == false
      @display_result = "Sorry but #{params[:word]} can't be built out of #{@letters}"
    elsif verify_words["found"] == false
      @display_result = "Sorry but #{params[:word]} does not seem to be a valid English word..."
    else
      @display_result = "Congratulations! #{params[:word]} is a valid English word!"
    end
  end
end
