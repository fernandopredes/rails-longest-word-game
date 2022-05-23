require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    if include?
      if valid_word?
        @result = 'É válido'
      else
        @result = 'Não é válido'
      end
    else
      @result = 'não está incluido'
    end
  end

  def include?
    @each_letter = params[:letter].split
    @word = params[:word].downcase
    @word.chars.all? do |letter|
      @word.count(letter) <= @each_letter.count(letter)
    end
  end

  def valid_word?
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    response = URI.open(url).read
    validation = JSON.parse(response)
    validation['found']
  end
end
