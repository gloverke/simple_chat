SimpleChat::Engine.routes.draw do

  post 'messages/send_message'
  get 'messages/events/:room_id', to: 'messages#events', as: 'streaming_events'
  post 'users/change_name', to:  'users#change_name'
  resources :rooms

end
