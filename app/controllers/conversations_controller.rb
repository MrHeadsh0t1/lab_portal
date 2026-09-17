class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.conversations.order(created_at: :desc)
  end

  def new
    @conversation = Conversation.new
    @users = User.where.not(id: current_user.id).order(:username)
  end

  def create
    @conversation = current_user.created_conversations.build(
      name: params[:conversation][:name]
    )

    if @conversation.save
      @conversation.conversation_members.create(user: current_user)

      user_ids = Array(params[:conversation][:user_ids])

      User.where(id: user_ids).each do |user|
        @conversation.conversation_members.create(user: user)
      end

      redirect_to @conversation,
                  notice: "Group created successfully."
    else
      @users = User.where.not(id: current_user.id).order(:username)
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @conversation = current_user.conversations.find(params[:id])
    @messages = @conversation.messages.includes(:sender).order(:created_at)
  end

  def send_message
    @conversation = current_user.conversations.find(params[:id])

    message = @conversation.messages.build(
      sender: current_user,
      content: params[:content],
      read: false
    )

    if message.save
      @conversation.users.where.not(id: current_user.id).each do |user|
        user.notifications.create(
          message: "New message in #{@conversation.name} from #{current_user.username}",
          read: false
        )
      end

      redirect_to @conversation
    else
      redirect_to @conversation,
                  alert: "Message cannot be empty."
    end
  end
end