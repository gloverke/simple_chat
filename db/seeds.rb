user = SimpleChat::User.create(name: 'Admin')
SimpleChat::Room.create(name: 'Lobby', user: user)