class ComputeRatingWorker
  include Sidekiq::Worker

  def perform(ranking_id)
    @ranking = Ranking.find(ranking_id)
    ActiveRecord::Base.transaction do
      actions
    end
    @ranking.update(compute_state: :success)
  rescue Exception => e
    @ranking.update(compute_state: :failure)
    raise e
  end

  def actions; end
end
