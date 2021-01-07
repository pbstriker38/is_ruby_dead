require 'sinatra'
require_relative 'answer_randomizer'

get '/' do
  @answer = AnswerRandomizer.random_answer
  erb :index
end

get '/ruby.png' do
  puts 'Hi!!'
  send_file 'ruby.png'
end
