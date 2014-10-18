require "thread"
require 'logger'
require 'digest/sha1'
module SimpleChat
  class SSESubscriber

    cattr_accessor :subscribers, :queue
    cattr_writer :thread

    @@subscribers = {}
    @@queue = Queue.new

    def self.create_thread
      Rails.logger.info "  == Starting queue thread"
      Thread.new do
        while event = @@queue.pop
          Rails.logger.info "  == popped message #{event.to_s}"
          subscribers.values.each do |sub_queue|
            Rails.logger.info '  == calling subscriber'
            sub_queue.push event
          end
        end
      end
    end

    def self.subscribe(sub_queue)
      # Rails.logger.info '  == subscribing'
      @@thread = SSESubscriber.create_thread unless @@thread
      Rails.logger.info "Thread: #{@@thread}"
      key = Digest::SHA1.hexdigest([Time.now, rand].join)
      @@subscribers[key] = sub_queue
      key
    end

    def self.unsubscribe key
      @@subscribers.delete key
    end

    def self.send_event(event, data)
      # Thread.new() do
      Rails.logger.info " == sending event: #{event} #{data} "
      @@queue << [event, data]
      # end
    end
  end

  class EventConsumer

  end
end