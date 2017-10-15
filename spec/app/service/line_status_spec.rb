require "spec_helper"

RSpec.describe Naantala::Service::LineStatus do
  def app
    Naantala::Service::LineStatus
  end

  describe "#check_status" do
    shared_context "methods" do
      before do
        allow(app).to receive_messages(latest_status: status)
      end
    end

    context "invalid status" do
      context "unsatisfied params" do
        include_context "methods" do
          let(:status) { build(:status, status: "CAT 2") }
        end

        it "does not save the status" do
          expect { app.check_status }.not_to change {
            Naantala::Models::Status.count
          }
        end
      end

      context "existing status" do
        include_context "methods" do
          let(:existing) { create(:status) }
          let(:status) do
            keys = %i{time description status station bound}
            build(:status, existing.attributes.slice(*keys))
          end
        end

        it "does not save the status" do
          expect { app.check_status }.not_to change {
            Naantala::Models::Status.count
          }
        end
      end
    end

    context "valid status" do
      include_context "methods" do
        let(:status) { build(:status) }
      end

      it "saves the status" do
        expect { app.check_status }.to change {
          Naantala::Models::Status.count
        }.by(1)
      end

      it "notifies all subscribers" do
        expect(Naantala::Service::Notifier)
          .to receive(:notify_subscribers!)
          .with(status)
        app.check_status
      end
    end
  end
end
