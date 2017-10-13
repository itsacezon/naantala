require "spec_helper"
require "app/controllers"

RSpec.describe Naantala::Controllers::Index do
  def app
    Naantala::Controllers::Index
  end

  describe "GET /" do
    it "renders index view" do
      get "/"

      expect(last_response).to be_ok
      expect(last_response.body).to include("Hello")
    end
  end

  descript "POST /phone/new" do
  end
end
