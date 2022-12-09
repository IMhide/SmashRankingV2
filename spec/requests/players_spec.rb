require 'rails_helper'

RSpec.describe "Players", type: :request do
  describe "GET /show" do
    it "returns http success" do
      get "/players/show"
      expect(response).to have_http_status(:success)
    end
  end

end
