class MockRedisPubSub

  attr_accessor :published

  def initialize
    @published = []
  end

  def publish(event,message)
    @published << {event: event, message: message}
  end


  def count
    @published.length
  end

  def published? event = nil, message= nil
    @published.select {|pub| !event || pub[:event].gsub(event).count > 0}
      .select { |pub| !message || pub[:message].gsub(message).count > 0}
       .length > 0
  end




end