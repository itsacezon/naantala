require "spec_helper"
require "lib/semaphore_api"

RSpec.describe Naantala::Service::Notifier do
  def app
    Naantala::Service::Notifier
  end

  describe "#build_message" do
    context "status description" do
      context "does not contain the station name" do
        let(:status) { build(:status, station: "Ortigas") }

        it "doesn't ignore the station attribute" do
          expect(app.build_message(status)).to include("Station: #{status.station}")
        end
      end

      context "contains the station name" do
        shared_examples "message is built" do
          it "ignores the station attribute" do
            expect(app.build_message(status)).not_to include("Station: #{status.station}")
          end
        end

        context "station does not have dashes" do
          it_behaves_like "message is built" do
            let(:status) { build(
              :status,
              station: "Ortigas",
              description: "Issue at Ortigas Station SB"
            ) }
          end
        end

        context "station has dashes" do
          it_behaves_like "message is built" do
            let(:status) { build(
              :status,
              station: "Santolan Annapolis - Ortigas",
              description: "Issue at Ortigas Station SB"
            ) }
          end
        end
      end

      shared_context "time" do
        let(:time) { Time.parse("October 24, 2017 6:32 PM +0800") }
        let(:time_string) { time.strftime("%l:%M %p").strip }
      end

      context "does not contain the status time" do
        include_context "time" do
          let(:status) { build(:status, time: time) }
        end

        it "doesn't ignore the time attribute" do
          expect(app.build_message(status)).to include("Time: #{time_string}")
        end
      end

      context "contains the status time" do
        include_context "time" do
          let(:status) { build(
            :status,
            time: time,
            description: "Issue on station at #{time_string.gsub(" ", "")}"
          ) }
        end

        it "ignores the time attribute" do
          expect(app.build_message(status)).not_to include("Time: #{time_string}")
        end
      end
    end
  end

  describe "#notify_subscribers!" do
    let(:client) { instance_double(SemaphoreApi) }
    let(:unconfirmed_number) { create(:phone_number, confirmed: false) }
    let(:confirmed_number) { create(:phone_number) }
    let(:status) { build(:status) }

    before do
      allow(app).to receive_messages(build_message: "Message", client: client)
    end

    it "ignores unconfirmed numbers" do
      expect(client).to receive(:send_message).with(
        message: "Message",
        numbers: confirmed_number.number
      )
      app.notify_subscribers!(status)
    end
  end
end
