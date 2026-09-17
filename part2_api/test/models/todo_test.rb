require "test_helper"

class TodoTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(
      name: "Test User",
      email: "todo@test.com",
      password: "123456"
    )
  end

  test "creates a valid todo" do
    todo = @user.todos.new(
      title: "Test Todo",
      created_by: @user.id
    )

    assert todo.valid?
  end

  test "requires a title" do
    todo = @user.todos.new(created_by: @user.id)

    assert_not todo.valid?
  end

  test "belongs to a user" do
    todo = Todo.new(
      title: "Test Todo",
      created_by: @user.id
    )

    assert_not todo.valid?
  end
end