require "test_helper"

class ItemTest < ActiveSupport::TestCase
  setup do
    @user = User.create!(
      name: "Test User",
      email: "item@test.com",
      password: "123456"
    )

    @todo = @user.todos.create!(
      title: "Test Todo",
      created_by: @user.id
    )
  end

  test "creates a valid item" do
    item = @todo.items.new(
      name: "Test Item",
      done: false
    )

    assert item.valid?
  end

  test "requires a name" do
    item = @todo.items.new(done: false)

    assert_not item.valid?
  end

  test "belongs to a todo" do
    item = Item.new(
      name: "Test Item",
      done: false
    )

    assert_not item.valid?
  end
end