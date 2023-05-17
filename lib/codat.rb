require "codat/version"
require "faraday"
require "faraday_middleware"
require "faraday_curl"

require_relative "codat/version"

module Codat
  autoload :BaseClient, "codat/base_client"
  autoload :Client, "codat/client"
  autoload :Types, "codat/types"
  autoload :Error, "codat/error"

  @api_base_url = "https://api.codat.io"

  class << self
    attr_accessor :api_base_url, :encoded_api_key, :debug_logger

    def client
      @client ||= Client.new(
        api_base_url: Codat.api_base_url,
        encoded_api_key: Codat.api_key
      )
    end
  end
end
