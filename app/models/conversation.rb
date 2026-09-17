class Conversation < ApplicationRecord
  belongs_to :creator, class_name: "User"

  has_many :conversation_members, dependent: :destroy
  has_many :users, through: :conversation_members
  has_many :messages, dependent: :destroy

  validates :name, presence: true
end