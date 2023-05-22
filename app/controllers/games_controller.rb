require 'open-uri'

class GamesController < ApplicationController

  def home
  end

  def new
    @letters = ('a'..'z').to_a.sample(10)
    @start = params[:start]
  end

  def score
    @attempt = params[:word]
    @letters = params[:letter]
    if (@attempt.chars - @letters.chars).empty? && englishword(@attempt)
      @response = "The word exists."
    elsif englishword(@attempt) == false
      @response = "It's not an english word."
    else
      @response = 'The word is not using the letters prompted.'
    end
  end

  def englishword(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    parsed = JSON.parse(response.read)
    parsed['found']
  end

end
