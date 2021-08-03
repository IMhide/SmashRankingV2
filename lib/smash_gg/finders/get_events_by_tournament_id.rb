module SmashGg
  class GetEventsByTournamentId < BaseFinder
    EventStruct = Struct.new(:event_remote_id, :name, :slug, :participants_count)
    TournamentQuery = GraphClient.parse <<-'GRAPHQL'
    query($slug: String!) {
      tournament(slug: $slug) {
        events {
          id
          name
          numEntrants
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
        EventStruct.new(hash['id'], hash['name'], hash['slug'], hash['numEntrants'])
      end
    end
  end
end
