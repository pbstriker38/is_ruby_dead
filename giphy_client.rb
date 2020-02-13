require 'net/http'

class GiphyClient
  def self.random_gif(tag: nil, rating: 'G')
    uri = URI('https://api.giphy.com/v1/gifs/random')
    params = { api_key: ENV['GIPHY_API_KEY'], tag: tag, rating: rating }.compact
    uri.query = URI.encode_www_form(params)

    response = Net::HTTP.get_response(uri)
    return nil unless response.is_a?(Net::HTTPSuccess)

    JSON.parse(response.body).dig('data', 'images', 'fixed_height', 'webp')
  end
end
