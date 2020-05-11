require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end
  def score
    @word = params[:word]
    @letter_array = params[:letter_array]
    if word_in_grid?(@word, @letter_array) == false
      @answer = "Sorry but your #{@word} cannot be built from the grid"
    elsif english_word?(@word) == false
      @answer = "Sorry but #{@word} does not seem to be a valid English word"
    else
      @answer = "Congratulations! #{@word} is a valid English word"
    end
  end
  def word_in_grid?(word, letter_array)
    word.split(" ").all? do |char|
      letter_array.count(char) >= word.count(char)
    end
  end
  def english_word?(word)
    url = open("https://wagon-dictionary.herokuapp.com/#{word}")
    dictionary = JSON.parse(url.read)
    dictionary["found"]
  end
end
