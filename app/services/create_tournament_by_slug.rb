class CreateTournamentBySlug < BaseService
  def initialize(tournament:)
    @tournament = tournament
  end

  def call
    remote_informations = SmashGg::Finders::GetFinishedTournamentBySlug.call(slug: @tournament.slug)
    if remote_informations.empty?
      false
    else
      @tournament.assign_attributes(remote_informations)
      @tournament.save
      @tournament
    end
  end
end
