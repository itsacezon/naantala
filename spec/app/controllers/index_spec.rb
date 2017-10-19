require "spec_helper"

RSpec.describe Naantala::Controllers::Index do
  def app
    Naantala::Controllers::Index
  end

  describe "GET /" do
    it "renders index view" do
      get "/"

      expect(last_response).to be_ok
      expect(last_response.body).to include("Naantala")
    end
  end
end
