class GetMatchesWorker
  include Sidekiq::Worker

  def perform(_tournament_id, _remote_event_id)
    ActiveRecord::Base.transaction do
      actions
    end
  end

  private

  def actions; end
end
