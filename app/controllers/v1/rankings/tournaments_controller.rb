module V1
  module Rankings
    class TournamentsController < ::V1::ApplicationController
      def index
        player = Player.find(params[:player_id])
        payload = player.tournaments.includes(:participations)
          .where(ranking_id: params[:ranking_id]).order(dated_at: :desc).map do |tournament|
            player_participation = tournament.participations.where(player: player).first
            all_matches = tournament.matches.where(winner: player).or(tournament.matches.where(looser: player))
            matches_won = all_matches.count { |m| m.winner_id == player.id }
            matches_lost = all_matches.count { |m| m.looser_id == player.id }

            {
              name: tournament.name,
              tier: tournament.tier,
              seed: player_participation.seed,
              placement: player_participation.placement,
              match_count: "#{matches_won} - #{matches_lost}"
            }
          end
        render json: payload, include: :participations
      end
    end
  end
end
