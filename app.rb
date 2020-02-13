require 'sinatra'

APP_URL = settings.production? ? 'https://is-ruby-dead.herokuapp.com' : 'http://localhost:4567'

YES_SAD = OpenStruct.new(response: '<h1>Yes 🥺</h1>', color: '#1bb535')
YES_FACEPALM = OpenStruct.new(response: '<h1>Yes 🤦🏾‍♀️</h1>', color: '#1bb535')
NO = OpenStruct.new(response: '<h1>No 🙅🏽‍♂️</h1>', color: '#cc4c42')
BENDER_LAUGH = OpenStruct.new(response: "<img src='#{APP_URL}/bender_laugh.gif'>", color: '#cc4c42')
MAYBE = OpenStruct.new(response: '<h1>Maybe 🤷🏻‍♂️</h1>', color: '#d6d016')
UNLIKELY = OpenStruct.new(response: '<h1>Unlikely 🦄</h1>', color: '#d68916')
PREPOSTEROUS = OpenStruct.new(response: '<h1>Preposterous 🤨</h1>', color: '#cc4c42')
ANSWERS = [YES_SAD, YES_FACEPALM, NO, MAYBE, BENDER_LAUGH, UNLIKELY, PREPOSTEROUS]

get '/' do
  @app_icon = settings.production? ? "#{APP_URL}/ruby.png" : "#{APP_URL}/ruby.png"
  @answer = ANSWERS.sample
  erb :index
end

get '/ruby.png' do
  send_file 'ruby.png'
end

get '/bender_laugh.gif' do
  send_file 'bender_laugh.gif'
end
