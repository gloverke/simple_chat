$redis = Redis.new host: ENV["REDIS_HOST"], port: ENV["REDIS_PORT"]


heartbeat_thread = Thread.new do
  while true
    puts "Heartbeat: ACK"
    $redis.publish("heartbeat","ACK")
    sleep 10.seconds
  end
end

at_exit do
  # not sure this is needed, but just in case
  heartbeat_thread.kill
  $redis.quit
end