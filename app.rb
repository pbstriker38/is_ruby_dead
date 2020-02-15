require 'sinatra'
require_relative 'answer_randomizer'

APP_URL = settings.production? ? 'https://is-ruby-dead.herokuapp.com' : 'http://localhost:4567'

get '/' do
  @app_icon = settings.production? ? "#{APP_URL}/ruby.png" : "#{APP_URL}/ruby.png"
  @answer = AnswerRandomizer.random_answer

  erb :index
end

get '/ruby.png' do
  send_file 'ruby.png'
end

get '/bender_laugh.gif' do
  send_file 'bender_laugh.gif'
end
