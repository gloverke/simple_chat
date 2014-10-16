# config/puma.rb
#threads 5,25
#workers 10
threads 5,10
workers 10
preload_app!
# worker_timeout 60

on_worker_boot do

  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end

end
