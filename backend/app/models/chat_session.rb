class ChatSession < ApplicationRecord
  belongs_to :user

  attribute :messages, :json, default: []

  def display_title
    title.presence || "New conversation"
  end
end
