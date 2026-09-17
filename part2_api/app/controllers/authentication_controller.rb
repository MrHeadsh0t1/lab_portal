class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request, only: [:signup, :login]
  def signup
    user = User.new(user_params)

    if user.save
      render json: {
        message: "Signup successful",
        token: user.auth_token,
        user: {
          id: user.id,
          name: user.name,
          email: user.email
        }
      }, status: :created
    else
      render json: {
        errors: user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      user.update!(auth_token: SecureRandom.hex(24))

      render json: {
        message: "Login successful",
        token: user.auth_token
      }, status: :ok
    else
      render json: {
        error: "Invalid email or password"
      }, status: :unauthorized
    end
  end

  def logout
    token = request.headers["Authorization"]&.remove("Bearer ")
    user = User.find_by(auth_token: token)

    if user
      user.update!(auth_token: nil)

      render json: {
        message: "Logout successful"
      }, status: :ok
    else
      render json: {
        error: "Unauthorized"
      }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end