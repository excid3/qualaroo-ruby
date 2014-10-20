require "qualaroo/version"
require "httparty"

module Qualaroo
  class Client
    include HTTParty
    base_uri 'app.qualaroo.com/api/v1'
    format :json

    attr_accessor :api_key, :api_secret

    def initialize(api_key, api_secret)
      @auth = {
        username: api_key || self.class.api_key || ENV['QUALAROO_API_KEY'],
        password: api_secret || self.class.api_secret || ENV['QUALAROO_API_SECRET']
      }
    end

    def responses(nudge_id, query={}, options={})
      options.merge!(basic_auth: @auth, query: query)
      self.class.get("/nudges/#{nudge_id}/responses.json", options)
    end

    def all_responses(nudge_id, query={}, options={})
      offset = 0
      all_responses = []

      while (page_responses = responses(nudge_id, query.merge(offset: offset), options)) && page_responses.any?
        all_responses += page_responses
        offset += 500
      end

      all_responses
    end

    class << self
      attr_accessor :api_key, :api_secret

      def method_missing(sym, *args, &block)
        new(api_key, api_secret).send(sym, *args, &block)
      end
    end
  end
end
