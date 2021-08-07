require 'graphql/client'
require 'graphql/client/http'

module SmashGg
  class BaseFinder
    GHTTP = GraphQL::Client::HTTP.new('https://api.smash.gg/gql/alpha') do
      def headers(_context)
        {Authorization: "Bearer #{ENV["SGG_API_TOKEN"]}"}
      end
    end

    Schema = GraphQL::Client.load_schema(GHTTP)
    GraphClient = GraphQL::Client.new(schema: Schema, execute: GHTTP)
  end
end
