class Message < ApplicationRecord
  belongs_to :sender, class_name: "User"

  belongs_to :receiver,
             class_name: "User",
             optional: true

  belongs_to :conversation,
             optional: true

  validates :content, presence: true

  scope :between, ->(user1, user2) {
    where(sender_id: user1.id, receiver_id: user2.id)
      .or(where(sender_id: user2.id, receiver_id: user1.id))
      .order(:created_at)
  }
end