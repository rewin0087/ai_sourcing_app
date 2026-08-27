class ChatSession < ApplicationRecord
  belongs_to :user

  validates :messages, presence: false

  def display_title
    title.presence || "New conversation"
  end
end
