= SimpleChat

This a sample rails4 engine.  It started as a place to experiment with Server Side Events. Specifically to have a sandbox to explore the bug identified here https://github.com/rails/rails/issues/10989

I've repurposed it to provide code samples to interested parties.

# Running the engine solo

 cd specs/dummy
 bundle exec puma -p 3000 -S ~/puma -C config/puma.rb

Then open http://localhost:3000/simple_chat/rooms


# Mounting the engine into an app

### Requirements

You need to have redis installed

### Add Gems

Add the following gems to your gem file. I'm using puma, but you may be using something else.  Since
simple_chat uses ServerSideEvents your chosen server needs to be multi-threaded.

 gem 'simple_chat', :git => 'https://github.com/gloverke/simple_chat.git'
 gem 'puma'
 gem 'gon'
 gem 'redis'
 gem "jquery-ui-rails"
 gem 'handlebars_assets'
 gem 'bootstrap-sass'
 gem 'autoprefixer-rails'

### Update the routes file

The mounts all of the simple chat routes into your application.

 mount SimpleChat::Engine, at: "/simple_chat"

### Update the database

Install the migrations, and run them.  The SCOPE tag will run only the migrations associated with
the engine specificed.

 rake simple_chat:install:migrations
 rake SCOPE=simple_chat db:migrate

Load the simple_chats seeds into your seeds.rb file

 #seeds.rb
 SimpleChat::Engine.load_seed

Run the seeds with the same scope tags

 rake SCOPE=simple_chat db:seed

### Setting up redis

This sets up the redis connection and creates a heartbeat thread.  The heartbeat should not be necessary,
but due to the bug mentioned above it is.  Every 5 seconds is sends a message to the heartbeat queue. Every
stream subscribes to it.  If the browser has closed, or navigated away from the site the heartbeat will
cause the stream to error, close, and release the thread.  If you don't do this you will slowly lose
all of your threads until the site is unusable

 #initializers/redis.rb
 $redis = Redis.new host: ENV["REDIS_HOST"], port: ENV["REDIS_PORT"]

 #Heartbeat is only needed until Rails4.2 which fixes the thread hang bug
 heartbeat_thread = Thread.new do
  while true
    $redis.publish("heartbeat","ACK")
    sleep 5.seconds
  end
 end

 at_exit do
  heartbeat_thread.kill
  $redis.quit
 end

### Run it

 bundle exec puma -p 3000 -S ~/puma -C config/puma.rb


In case you don't have a puma.rb

 #config/puma.rb
 threads 5,10
 workers 10
 preload_app!

 on_worker_boot do

  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end

 end
