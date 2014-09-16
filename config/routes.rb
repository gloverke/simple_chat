SimpleChat::Engine.routes.draw do

  post 'messages/send_message'
  get 'messages/events/:room_id', to: 'messages#events', as: 'streaming_events'

  resources :rooms

end
