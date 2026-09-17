class Notification < ApplicationRecord
  belongs_to :user

  validates :message, presence: true

  after_create_commit :broadcast_notification

  private

  def broadcast_notification
    broadcast_update_to(
      "notifications_user_#{user_id}",
      target: "notification_counter",
      partial: "notifications/counter",
      locals: { user: user }
    )

    broadcast_append_to(
      "notifications_user_#{user_id}",
      target: "notification_popups",
      partial: "notifications/popup",
      locals: { notification: self }
    )
  end
end