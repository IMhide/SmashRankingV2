class ComputeRating < BaseService
  def initialize(ranking:)
    @ranking = ranking
  end

  def call
    true
  end
end
