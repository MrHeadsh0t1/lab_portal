require "test_helper"

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test "signup creates a new user" do
    assert_difference("User.count", 1) do
      post "/signup", params: {
        name: "New User",
        email: "newuser@test.com",
        password: "123456",
        password_confirmation: "123456"
      }
    end

    assert_response :created

    body = JSON.parse(response.body)

    assert_equal "Signup successful", body["message"]
    assert_not_nil body["token"]
    assert_equal "newuser@test.com", body["user"]["email"]
  end

  test "login with correct credentials" do
    User.create!(
      name: "Login User",
      email: "login@test.com",
      password: "123456"
    )

    post "/auth/login", params: {
      email: "login@test.com",
      password: "123456"
    }

    assert_response :success

    body = JSON.parse(response.body)

    assert_equal "Login successful", body["message"]
    assert_not_nil body["token"]
  end

  test "login with incorrect password returns unauthorized" do
    User.create!(
      name: "Login User",
      email: "wrong@test.com",
      password: "123456"
    )

    post "/auth/login", params: {
      email: "wrong@test.com",
      password: "wrongpassword"
    }

    assert_response :unauthorized
  end

  test "logout invalidates authentication token" do
    user = User.create!(
      name: "Logout User",
      email: "logout@test.com",
      password: "123456"
    )

    token = user.auth_token

    get "/auth/logout",
        headers: { "Authorization" => "Bearer #{token}" }

    assert_response :success

    user.reload
    assert_nil user.auth_token
  end
end