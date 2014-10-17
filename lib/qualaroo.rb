require "qualaroo/version"

module Qualaroo
  class Client
    include HTTParty
    base_uri 'app.qualaroo.com/api/v1'
    format :json

    def initialize(key, secret)
      @auth = {username: key, password: secret}
    end

    def responses(survey_id, options={})
      options.merge!(basic_auth: @auth)
      self.class.get "/nudges/#{survey_id}/responses.json", options
    end
  end
end
