require "spec_helper"

RSpec.describe Naantala::Service::StatusParser do
  def app
    Naantala::Service::StatusParser
  end

  describe "#statuses" do
    context "correct url" do
      let(:parser) { app.new(url: "https://dotcmrt3.gov.ph/service-status") }

      it "parses data" do
        statuses = parser.statuses
        expect(statuses).not_to be_empty
      end

      it "has correct keys for an element" do
        status = parser.statuses.first

        expect(status).to have_key(:time)
        expect(status).to have_key(:description)
        expect(status).to have_key(:status)
        expect(status).to have_key(:station)
        expect(status).to have_key(:bound)
      end
    end

    context "incorrect url" do
      let(:parser) { app.new(url: "http://example.com") }

      it "doesn't parse data" do
        statuses = parser.statuses
        expect(statuses).to be_empty
      end
    end
  end
end
