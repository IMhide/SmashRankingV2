module SmashGg
  class GetEventsByTournamentId < BaseFinder
    EventStruct = Struct.new(:event_remote_id, :name, :slug)
    TournamentQuery = GraphClient.parse <<-'GRAPHQL'
    query($slug: String!) {
      tournament(slug: $slug) {
        events {
          id
          name
          slug
        }
      }
    }
    GRAPHQL

    def self.call(slug:)
      result = GraphClient.query(TournamentQuery, variables: { slug: slug }).original_hash.dig('data', 'tournament',
                                                                                               'events')
      format(result) unless result.nil?
    end

    def self.format(events)
      events.map do |hash|
        EventStruct.new(hash['id'], hash['name'], hash['slug'])
      end
    end
  end
end
