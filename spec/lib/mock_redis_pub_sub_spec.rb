require "mock_redis_pub_sub"

RSpec.describe MockRedisPubSub do
  let(:event) { {event: 'event', message: 'message'} }
  before :each do
    @pubsub = MockRedisPubSub.new
  end

  context ".publish" do
    it "allows messages to be sent to a queue" do
      @pubsub.publish(*event.values)
      expect(@pubsub.published).to eq [event]
    end
  end

  context ".published?" do
    before(:each) do
      @pubsub.publish(*event.values)
    end
    it "returns true if exact" do
      expect(@pubsub.published? "event", "message").to eq true
    end

    it "returns true with regex on event and message" do
      expect(@pubsub.published?  /vent/, /sage/).to eq true
    end

    it "returns true with regex on event only" do
      expect(@pubsub.published?  /vent/).to eq true
    end

    it "returns true with regex on message only" do
      expect(@pubsub.published?  nil, /sage/).to eq true
    end

    it "returns false with wrong regex" do
      expect(@pubsub.published? /rah/, /yup/).to eq false
    end

    it "returns false with event correct and message wrong" do
      expect(@pubsub.published? /vent/, /yup/).to eq false
    end

  end

  context ".count" do
    it "returns the number of messages published" do
      @pubsub.publish(*event.values)
      expect(@pubsub.count).to eq 1
    end

  end
end
