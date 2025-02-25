require "graphql/client"
require "graphql/client/http"

# Lightspark API wrapper
module Lightspark
  # Configure GraphQL endpoint using the basic HTTP network adapter.
  HTTP = GraphQL::Client::HTTP.new("https://api.lightspark.com/graphql/server/2023-09-13") do
    def headers(context)
      # Optionally set any HTTP headers
      { "User-Agent": "Test Client" }
    end
  end  

  # Fetch latest schema on init, this will make a network request
  # Schema = GraphQL::Client.load_schema(HTTP)

  # However, it's smart to dump this to a JSON file and load from disk
  #
  # Run it from a script or rake task
  #   GraphQL::Client.dump_schema(Lightspark::HTTP, "path/to/schema.json")
  #
  Schema = GraphQL::Client.load_schema("schema.json")

  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
end
