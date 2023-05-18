module Codat
  class Client < BaseClient
    autoload :Common, "codat/client/common"
    autoload :Accounting, "codat/client/accounting"

    include Common
    include Accounting

    def initialize(api_base_url: nil, encoded_api_key: nil, headers: {})
      api_base_url ||= Codat.api_base_url
      encoded_api_key ||= Codat.encoded_api_key
      super(api_base_url: api_base_url, headers: headers.merge(default_headers(encoded_api_key)))
    end

    def inspect
      %Q(#<Codat::Client:0x#{"%016X" % object_id}>)
    end

    private

    def default_headers(encoded_api_key)
      {
        "User-Agent" => "Codat v#{Codat::VERSION}",
        "Content-Type" => "application/json",
        "Authorization" => "Basic #{encoded_api_key}"
      }
    end
  end
end
