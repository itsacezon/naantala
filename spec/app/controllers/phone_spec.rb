require "spec_helper"

RSpec.describe Naantala::Controllers::Phone do
  def app
    Naantala::Controllers::Phone
  end

  describe "POST /phone/new" do
    it "renders phone view" do
      post "/phone/new"

      expect(last_response).to be_ok
      expect(last_response.body).to include("Hello")
    end
  end
end
