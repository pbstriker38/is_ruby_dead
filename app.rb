require 'sinatra'
require_relative 'answer_randomizer'

class App < Sinatra::Base
  set :static_cache_control, [:public, max_age: 300]

  get '/' do
    @answer = AnswerRandomizer.random_answer

    erb :index
  end
end
