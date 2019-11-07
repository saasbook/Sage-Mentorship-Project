require 'rails_helper'

RSpec.describe "Mentors", type: :request do
  describe "GET /mentors" do
    it "works! (now write some real specs)" do
      get mentors_path
      expect(response).to have_http_status(200)
    end
  end
end
