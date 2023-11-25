require 'sinatra'
require_relative 'answer_randomizer'

class App < Sinatra::Base
  get '/' do
    @answer = AnswerRandomizer.random_answer

    erb :index
  end

  get '/ruby.png' do
    send_file 'ruby.png'
  end
end
