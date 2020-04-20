require 'net/http'
require_relative 'app_logger'

class GiphyClient
  def self.random_gif(tag: nil, rating: 'G')
    uri = URI('https://api.giphy.com/v1/gifs/random')
    params = { api_key: ENV['GIPHY_API_KEY'], tag: tag, rating: rating }.compact
    uri.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(uri)
    AppLogger.logger.info("Giphy response: #{response}")
    return nil unless response.is_a?(Net::HTTPSuccess)

    AppLogger.logger.info("Giphy response body: #{response.body}")

    JSON.parse(response.body).dig('data', 'images', 'fixed_height', 'url')
  rescue StandardError => e
    AppLogger.logger.error('Error getting random gif')
    AppLogger.logger.error(e)

    nil
  end
end
