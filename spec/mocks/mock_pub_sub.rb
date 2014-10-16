class MockPubSub
  
  def publish channel,message
    puts 'RECEIVED MSG: ' + channel.to_s + ' => ' + message.to_s
  end
  
   def method_missing m, *args
     puts "Missing Method: " + m.to_s + ' args: '+ args.to_s
    end
  
end