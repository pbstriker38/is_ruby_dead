require 'logger'

class AppLogger
  def self.logger
    @logger ||= Logger.new(STDOUT)
  end
end
