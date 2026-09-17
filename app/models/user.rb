class User < ApplicationRecord
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :validatable,
         :omniauthable,
         omniauth_providers: [:google_oauth2]

  # Posts
  has_many :posts, dependent: :destroy

  # Contacts
  has_many :contacts, dependent: :destroy

  has_many :contact_users,
           through: :contacts,
           source: :contact_user

  # Private Messages
  has_many :sent_messages,
           class_name: "Message",
           foreign_key: "sender_id",
           dependent: :destroy

  has_many :received_messages,
           class_name: "Message",
           foreign_key: "receiver_id",
           dependent: :destroy

  # Group Conversations
  has_many :conversation_members, dependent: :destroy

  has_many :conversations,
           through: :conversation_members

  has_many :created_conversations,
           class_name: "Conversation",
           foreign_key: "creator_id",
           dependent: :destroy

  # Notifications
  has_many :notifications, dependent: :destroy

  # Username validation
  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 30 }

  # Google OAuth
  def self.from_google(auth)
    user = find_by(provider: auth.provider, uid: auth.uid)

    return user if user

    user = find_or_initialize_by(email: auth.info.email)

    user.provider = auth.provider
    user.uid = auth.uid

    if user.username.blank?
      base_username = auth.info.email
                          .split("@")
                          .first
                          .downcase
                          .gsub(/[^a-z0-9_]/, "")

      username = base_username
      counter = 1

      while User.exists?(username: username)
        username = "#{base_username}#{counter}"
        counter += 1
      end

      user.username = username
    end

    if user.new_record?
      user.password = Devise.friendly_token[0, 20]
    end

    user.save!
    user
  end
end