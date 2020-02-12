require 'sinatra'

YES_SAD = OpenStruct.new(response: 'Yes 🥺', color: '#1bb535')
YES_FACEPALM = OpenStruct.new(response: 'Yes 🤦🏾‍♀️', color: '#1bb535')
NO = OpenStruct.new(response: 'No 🙅🏽‍♂️', color: '#cc4c42')
MAYBE = OpenStruct.new(response: 'Maybe 🤷🏻‍♂️', color: '#d6d016')
ANSWERS = [YES_SAD, YES_FACEPALM, NO, MAYBE]

get '/' do
  @app_icon = settings.production? ? 'https://is-ruby-dead.herokuapp.com/ruby.png' : 'http://localhost:4567/ruby.png'
  @answer = ANSWERS.sample
  erb :index
end

get '/ruby.png' do
  send_file 'ruby.png'
end
