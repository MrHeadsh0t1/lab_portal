class MessagesController < ApplicationController
  before_action :authenticate_user!

  def index
    @contacts = current_user.contact_users.order(:username)
  end

  def chat
    @other_user = User.find(params[:user_id])

    unless current_user.contact_users.exists?(@other_user.id)
      redirect_to users_path, alert: "This user is not in your contacts."
      return
    end

    @messages = Message.between(current_user, @other_user)

    Message.where(
      sender: @other_user,
      receiver: current_user,
      read: false
    ).update_all(read: true)
  end

  def create
    receiver = User.find(params[:receiver_id])

    unless current_user.contact_users.exists?(receiver.id)
      redirect_to users_path, alert: "This user is not in your contacts."
      return
    end

    message = current_user.sent_messages.build(
      receiver: receiver,
      content: params[:content],
      read: false
    )

    if message.save
      receiver.notifications.create(
        message: "New message from #{current_user.username}",
        read: false
      )

      redirect_to chat_path(receiver)
    else
      redirect_to chat_path(receiver),
                  alert: "Message cannot be empty."
    end
  end
end