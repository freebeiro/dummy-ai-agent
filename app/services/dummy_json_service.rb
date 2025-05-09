require 'httparty'

class DummyJsonService
  include HTTParty
  base_uri 'https://dummyjson.com'

  def self.fetch_products(limit: 10, skip: 0, select: 'title,price,thumbnail,description')
    options = { query: { limit: limit, skip: skip, select: select } }
    response = get('/products', options)
    if response.success?
      response.parsed_response['products']
    else
      # Basic error handling for PoC
      Rails.logger.error "DummyJSON API Error: #{response.code} - #{response.message}"
      [] # Return empty array on error
    end
  rescue HTTParty::Error => e
    Rails.logger.error "DummyJSON API HTTParty Error: #{e.message}"
    []
  rescue StandardError => e
    Rails.logger.error "DummyJSON API Standard Error: #{e.message}"
    []
  end
end
