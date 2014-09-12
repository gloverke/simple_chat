class CreateSimpleChatUsers < ActiveRecord::Migration
  def change
    create_table :simple_chat_users do |t|
      t.string :name
      t.integer :room_id
      t.string :font

      t.timestamps
    end
  end
end
