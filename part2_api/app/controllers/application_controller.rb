class ApplicationController < ActionController::API
  before_action :authenticate_request

  attr_reader :current_user

  private

  def authenticate_request
    header = request.headers["Authorization"].to_s

    unless header.start_with?("Bearer ")
      render json: { error: "Unauthorized" }, status: :unauthorized
      return
    end

    token = header.delete_prefix("Bearer ").strip

    if token.blank?
      render json: { error: "Unauthorized" }, status: :unauthorized
      return
    end

    @current_user = User.find_by(auth_token: token)

    unless @current_user
      render json: { error: "Unauthorized" }, status: :unauthorized
    end
  end
end