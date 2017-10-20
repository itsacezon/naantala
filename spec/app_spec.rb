require "spec_helper"

RSpec.describe Naantala::App do
  def app
    Naantala::App
  end

  describe "throttle excessive POST /phone/new requests" do
    let(:limit) { 5 }

    context "number of requests is lower than the limit" do
      it "does not change the request status" do
        limit.times do |i|
          post "/phone/new", { number: "8#{i}23456789" }, "REMOTE_ADDR" => "1.2.3.4"
          expect(last_response.status).not_to eq(429)
        end
      end
    end

    context "number of requests is higher than the limit" do
      it "changes the request status to 429" do
        (limit * 2).times do |i|
          post "/phone/new", { number: "9#{i}23456789" }, "REMOTE_ADDR" => "1.2.3.5"
          expect(last_response.status).to eq(429) if i > limit
        end
      end
    end
  end
end
