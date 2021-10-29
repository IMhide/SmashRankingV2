module SmashGg
  module Finders
    class GetTournamentByEventId < BaseFinder
      EventStruct = Struct.new(:id, :name, :slug, :dated_at)
      TournamentQuery = GraphClient.parse <<-'GRAPHQL'
    query($id: ID!) {
      event(id: $id) {
        tournament {
          id
          name
          startAt
          slug
        }
      }
    }
      GRAPHQL

      def self.call(event_id:)
        result = GraphClient.query(TournamentQuery, variables: {id: event_id})
          .original_hash.dig('data', 'event', 'tournament')
        format(result) unless result.nil?
      end

      def self.format(hash)
        EventStruct.new(hash['id'], hash['name'], hash['slug'], hash['startAt'])
      end
    end
  end
end
