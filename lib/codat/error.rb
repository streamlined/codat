module Codat
  class Error < StandardError
    ClientError           = Class.new(self)
    ServerError           = Class.new(self)

    BadRequest            = Class.new(ClientError)
    Unauthorized          = Class.new(ClientError)
    Forbidden             = Class.new(ClientError)
    Conflict              = Class.new(ClientError)
    RequestEntityTooLarge = Class.new(ClientError)
    NotFound              = Class.new(ClientError)
    NotAcceptable         = Class.new(ClientError)
    UnprocessableEntity   = Class.new(ClientError)
    TooManyRequests       = Class.new(ClientError)

    InternalServerError   = Class.new(ServerError)
    BadGateway            = Class.new(ServerError)
    ServiceUnavailable    = Class.new(ServerError)
    GatewayTimeout        = Class.new(ServerError)

    attr_reader :status_code
    attr_reader :error
    attr_reader :service
    attr_reader :correlation_id
    attr_reader :detaield_error_code
    attr_reader :can_be_retried

    def initialize(
      status_code: 500,
      error: "Something went wrong with communication with Codat API.",
      service: "API error",
      detailed_error_code: 500,
      correlation_id: nil,
      can_be_retried: "Unknown"
    )
      super
      @status_code = status_code
      @error = error
      @service = service
      @detailed_error_code = detailed_error_code
      @correlation_id = correlation_id
      @can_be_retried = can_be_retried
    end

    def self.from_response(status, body, _headers)
      parsed_error = parse_error(body)
      status_code = parsed_error.dig(:status_code)
      error = parsed_error.dig(:error)
      service = parsed_error.dig(:service)
      correlation_id = parsed_error.dig(:correlation_id)
      detailed_error_code = parsed_error.dig(:detailed_error_code)
      can_be_retried = parsed_error.dig(:can_be_retried)
      error = error_class(status_code)&.new(
        status_code: status_code,
        error: error,
        service: service,
        correlation_id: correlation_id,
        detailed_error_code: detailed_error_code,
        can_be_retried: can_be_retried
      )
      error ||= ClientError.new(
        status_code: status_code,
        error: error,
        service: service,
        correlation_id: correlation_id,
        detailed_error_code: detailed_error_code,
        can_be_retried: can_be_retried
      )
      error
    end

    def self.parse_error(body)
      {
        status_code: body.dig("statusCode"),
        error: body.dig("error"),
        service: body.dig("service"),
        correlation_id: body.dig("correlationId"),
        can_be_retried: body.dig("canBeRetried"),
        detailed_error_code: body.dig("detailedErrorCode")
      }
    end

    def self.error_class(status)
      ERRORS[status]
    end
  end

  ERRORS = {
    400 => Error::BadRequest, # invalid_parameters_error, malformed_request_error
    401 => Error::Unauthorized, # invalid_api_key_error
    403 => Error::Forbidden, # private_feature_error, insufficient_permissions_error, environment_mismatch_error
    404 => Error::NotFound, # object_not_found_error, api_method_not_found_error
    406 => Error::NotAcceptable,
    409 => Error::Conflict, # invalid_operation_error, idempotency_conflict_error
    413 => Error::RequestEntityTooLarge,
    422 => Error::UnprocessableEntity, # idempotency_unprocessable_error
    429 => Error::TooManyRequests, # rate_limited_error
    500 => Error::InternalServerError, # internal_server_error
    502 => Error::BadGateway,
    503 => Error::ServiceUnavailable,
    504 => Error::GatewayTimeout
  }.freeze
end
