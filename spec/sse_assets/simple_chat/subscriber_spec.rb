require "rails_helper"
require "thread"

module SimpleChat

  describe "SSE Subscriber" do

    before(:each) do
      SimpleChat::SSESubscriber.subscribers = {}
    end

    it 'allows messages to be added to the queue' do
      SimpleChat::SSESubscriber.send_event(:event, :data)

      assert_equal SimpleChat::SSESubscriber.queue.length, 1
      event, data = SimpleChat::SSESubscriber.queue.pop
      assert_equal event, :event
      assert_equal data, :data
    end

    it 'allows threads to subscribe' do
      SimpleChat::SSESubscriber.subscribe Queue.new
      assert_equal SimpleChat::SSESubscriber.subscribers.length, 1
    end


    it 'sends messages to subscribers' do
      queue = Queue.new
      reference = SimpleChat::SSESubscriber.subscribe queue
      t = Thread.new do
        event = queue.pop
        event, data = event
        assert_equal event, :event
        assert_equal data, :data
      end
      SimpleChat::SSESubscriber.send_event(:event, :data)
      t.join
      assert_equal 0, SimpleChat::SSESubscriber.queue.length
    end

    it 'returns a reference to unsubscribe' do
      reference = SimpleChat::SSESubscriber.subscribe Queue.new
      SimpleChat::SSESubscriber.unsubscribe reference
      assert_equal 0, SimpleChat::SSESubscriber.subscribers.length
    end

  end


end