require "spec_helper"
require "app/service/line_status"

RSpec.describe Naantala::Service::LineStatus do
  def app
    Naantala::Service::LineStatus
  end

  describe "#check_status" do
    context "invalid status" do
      let(:status) { build(:status) }
    end
  end
end
