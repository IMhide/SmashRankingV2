module SmashGg
  module Finders
    class GetFinishedTournamentBySlug < BaseFinder
      TournamentQuery = GraphClient.parse <<-'GRAPHQL'
    query($slug: String!) {
      tournament(slug: $slug) {
        id
        name
        startAt
        state
      }
    }
      GRAPHQL

      def self.call(slug:)
        result = GraphClient.query(TournamentQuery, variables: {slug: slug}).original_hash.dig('data', 'tournament')
        format(result) unless result.nil?
      end

      # Returning
      # {"name"=> String, "tournament_remote_id"=> INT:SGGID, "dated_at"=> DateTime}
      def self.format(hash)
        if hash['state'] != 3
          {}
        else
          new_hash = hash.dup
          new_hash[:tournament_remote_id] = new_hash.delete('id')
          new_hash[:dated_at] = Time.at(new_hash.delete('startAt')).to_datetime
          new_hash.delete('state')
          new_hash.with_indifferent_access
        end
      end
    end
  end
end
