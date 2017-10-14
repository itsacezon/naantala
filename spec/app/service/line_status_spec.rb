require "spec_helper"

RSpec.describe Naantala::Service::LineStatus do
  def app
    Naantala::Service::LineStatus
  end

  shared_context "parser" do
    before do
      parser = instance_double(Naantala::Service::StatusParser)
      allow(parser).to receive_messages(statuses: [status])
      allow(app).to receive_messages(parser: parser)
    end
  end

  describe "#check_status" do
    context "invalid status" do
      context "unsatisfied params" do
        include_context "parser" do
          let(:status) { build(:status, status: "CAT 2") }
        end

        it "does not save the status" do
          expect { app.check_status }.not_to change { Naantala::Models::Status.count }
        end
      end

      context "existing status" do
        include_context "parser" do
          let(:existing_status) { create(:status) }
          let(:status) { existing_status }
        end

        it "does not save the status" do
          expect { app.check_status }.not_to change { Naantala::Models::Status.count }
        end
      end
    end

    context "valid status" do
      include_context "parser" do
        let(:status) { build(:status) }
      end

      it "saves the status" do
        expect { app.check_status }.to change { Naantala::Models::Status.count }.by(1)
      end
    end
  end
end
