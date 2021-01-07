require_relative 'giphy_client'

class AnswerRandomizer
  YES_SAD = -> { OpenStruct.new(message: 'Yes 🥺', color: '#1bb535') }
  YES_FACEPALM = -> { OpenStruct.new(message: 'Yes 🤦🏾‍♀️', color: '#1bb535') }
  NO = -> { OpenStruct.new(message: 'No 🙅🏽‍♂️', color: '#cc4c42') }
  MAYBE = -> { OpenStruct.new(message: 'Maybe 🤷🏻‍♂️', color: '#d6d016') }
  UNLIKELY = -> { OpenStruct.new(message: 'Unlikely 🦄', color: '#d68916') }
  PREPOSTEROUS = -> { OpenStruct.new(message: 'Preposterous 🤨', color: '#cc4c42') }
  ARE_YOU_DEAD = -> { OpenStruct.new(message: 'Are you dead? 🧟', color: '#359c2e') }
  NEVER = -> { OpenStruct.new(message: 'Never 🙉', color: '#cc4c42') }

  ANSWERS = [YES_SAD, YES_FACEPALM, NO, MAYBE, UNLIKELY, PREPOSTEROUS, ARE_YOU_DEAD, NEVER].freeze

  def self.random_answer
    random_laugh_gif = -> { OpenStruct.new(
      message: 'LOL',
      image: GiphyClient.random_gif(tag: 'laughing', rating: 'PG-13'),
      color: '#cc4c42'
    ) }
    random_no_gif = -> { OpenStruct.new(
      message: 'No',
      image: GiphyClient.random_gif(tag: 'no', rating: 'PG-13'),
      color: '#cc4c42'
    ) }
    random_yes_gif = -> { OpenStruct.new(
      message: 'Yes',
      image: GiphyClient.random_gif(tag: 'sad', rating: 'PG-13'),
      color: '#1bb535'
    ) }
    random_never_gif = -> { OpenStruct.new(
      message: 'Never',
      image: GiphyClient.random_gif(tag: 'never', rating: 'PG-13'),
      color: '#cc4c42'
    ) }

    puts "hello"
    @answer = (ANSWERS + [random_laugh_gif, random_no_gif, random_yes_gif, random_never_gif]).sample.call
  end
end
