# frozen_string_literal: true

require './app'

RubyVM::YJIT.enable
puts "YJIT enabled: #{RubyVM::YJIT.enabled?}"

run App
