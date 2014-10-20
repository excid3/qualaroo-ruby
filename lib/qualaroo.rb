require "qualaroo/version"
require "httparty"

module Qualaroo
  class Client
    include HTTParty
    base_uri 'app.qualaroo.com/api/v1'
    format :json

    def initialize(key, secret)
      @auth = {username: key, password: secret}
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
  end
end
