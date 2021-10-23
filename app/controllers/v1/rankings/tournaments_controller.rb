module V1
  module Rankings
    class TournamentsController < ::V1::ApplicationController
      def index
        player = Player.find(params[:player_id])
        payload = player.tournaments.includes(:participations)
          .where(ranking_id: params[:ranking_id]).order(dated_at: :desc).map do |tournament|
            player_participation = tournament.participations.where(player: player).first
            all_matches = tournament.matches_for(player: player)
            matches_won = all_matches.count { |m| m.winner_id == player.id }
            matches_lost = all_matches.count { |m| m.looser_id == player.id }
            current_rating = get_last_rating(all_matches, player)
            previous_tournament = player.previous_tournament_for(ranking_id: params[:ranking_id], tournament: tournament)
            previous_rating = if previous_tournament.nil?
              base_rating = Rating.where(ranking_id: params[:ranking_id], base: true).first
              base_rating || Rating.new(mean: BigDecimal('25'), deviation: BigDecimal(25 / 3))
            else
              get_last_rating(previous_tournament.matches_for(player: player), player)
            end

            {
              name: tournament.name,
              tier: tournament.tier,
              seed: player_participation.seed,
              placement: player_participation.placement,
              match_count: "#{matches_won} - #{matches_lost}",
              point_diff: current_rating.score - previous_rating.score
            }
          end
        render json: payload, include: :participations
      end

      private

      def get_last_rating(matches, player)
        matches.order(completed_at: :desc).first.ratings.find_by(player: player)
      end
    end
  end
end
