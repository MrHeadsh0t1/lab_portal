require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "creates a valid user" do
    user = User.new(
      name: "Test User",
      email: "user@test.com",
      password: "123456",
      password_confirmation: "123456"
    )

    assert user.valid?
  end

  test "requires a name" do
    user = User.new(
      email: "user@test.com",
      password: "123456",
      password_confirmation: "123456"
    )

    assert_not user.valid?
  end

  test "requires an email" do
    user = User.new(
      name: "Test User",
      password: "123456",
      password_confirmation: "123456"
    )

    assert_not user.valid?
  end

  test "email must be unique" do
    User.create!(
      name: "User One",
      email: "same@test.com",
      password: "123456"
    )

    user = User.new(
      name: "User Two",
      email: "same@test.com",
      password: "123456"
    )

    assert_not user.valid?
  end

  test "generates authentication token when created" do
    user = User.create!(
      name: "Test User",
      email: "token@test.com",
      password: "123456"
    )

    assert_not_nil user.auth_token
  end
end