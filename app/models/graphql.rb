require "net/http"

module Graphql
  CURRENT_ACCOUNT_QUERY = <<-'GRAPHQL'
query GetCurrentAccount {
  current_account {
    ...AccountFragment
  }
}

fragment AccountFragment on Account {
  __typename
  account_id: id
  account_created_at: created_at
  account_updated_at: updated_at
  account_name: name
}
  GRAPHQL

  class LightsparkClient
    attr_reader :uri

    def initialize(uri)
      @uri = URI.parse(uri)
    end

    def execute(query_string, operation_name: nil, variables: {}, context: {})
      request = Net::HTTP::Post.new(uri.request_uri)
      request.basic_auth(api_client_id, api_token)

      request["Accept"] = "application/json"
      request["Content-Type"] = "application/json"

      body = {}
      body["query"] = query_string
      body["variables"] = variables if variables.any?
      body["operationName"] = operation_name if operation_name
      request.body = JSON.generate(body)

      response = connection.request(request)

      case response
      when Net::HTTPOK, Net::HTTPBadRequest
        JSON.parse(response.body)
      else
        { "errors" => [{ "message" => "#{response.code} #{response.message}" }] }
      end
    end

    # Returns a Net::HTTP object
    def connection
      Net::HTTP.new(uri.host, uri.port).tap do |client|
        client.use_ssl = uri.scheme == "https"
      end
    end

    def current_account
      execute(CURRENT_ACCOUNT_QUERY)
    end

    private

    def api_client_id
      ENV["LIGHTSPARK_API_TOKEN_CLIENT_ID"]
    end

    def api_token
      ENV["LIGHTSPARK_API_TOKEN_CLIENT_SECRET"]
    end
  end
end
