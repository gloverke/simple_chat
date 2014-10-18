require "simple_chat/engine"

module SimpleChat
  autoload :SSESubscriber, "simple_chat/sse_subscriber"

  # mattr_reader :subscribers
  # @@subscribers = []
  #
  # def self.subscribe(subscriber)
  #   subscribers << subscriber
  # end
  #
  # def self.unsubscribe(subscriber)
  #   subscribers.delete(subscriber)
  # end

end
