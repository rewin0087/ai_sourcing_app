class CreateChatSessions < ActiveRecord::Migration[7.2]
  def change
    create_table :chat_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title, default: ""
      t.jsonb :messages, default: []

      t.timestamps
    end

    add_index :chat_sessions, [:user_id, :updated_at]
  end
end
