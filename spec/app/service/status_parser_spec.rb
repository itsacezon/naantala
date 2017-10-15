require "spec_helper"

RSpec.describe Naantala::Service::StatusParser do
  def app
    Naantala::Service::StatusParser
  end

  describe "#statuses" do
    context "correct url" do
      let(:url) { "https://dotcmrt3.gov.ph/service-status" }

      it "parses data" do
        expect(app.statuses(url)).not_to be_empty
      end

      it "returns Status objects" do
        expect(app.statuses(url).first)
          .to be_an_instance_of(Naantala::Models::Status)
      end
    end

    context "incorrect url" do
      let(:url) { "http://example.com" }

      it "doesn't parse data" do
        expect(app.statuses(url)).to be_empty
      end
    end
  end
end
