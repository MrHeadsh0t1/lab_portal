require "test_helper"

class ItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      name: "Item User",
      email: "itemuser@test.com",
      password: "123456"
    )

    @token = @user.auth_token

    @todo = @user.todos.create!(
      title: "Todo With Items",
      created_by: @user.id
    )

    @item = @todo.items.create!(
      name: "Existing Item",
      done: false
    )
  end

  test "creates an item" do
    assert_difference("Item.count", 1) do
      post "/todos/#{@todo.id}/items",
           params: {
             name: "New Item",
             done: false
           },
           headers: auth_headers
    end

    assert_response :created

    body = JSON.parse(response.body)

    assert_equal "New Item", body["name"]
    assert_equal false, body["done"]
  end

  test "gets an item" do
    get "/todos/#{@todo.id}/items/#{@item.id}",
        headers: auth_headers

    assert_response :success

    body = JSON.parse(response.body)

    assert_equal @item.id, body["id"]
    assert_equal "Existing Item", body["name"]
  end

  test "updates an item" do
    put "/todos/#{@todo.id}/items/#{@item.id}",
        params: {
          name: "Updated Item",
          done: true
        },
        headers: auth_headers

    assert_response :success

    @item.reload

    assert_equal "Updated Item", @item.name
    assert_equal true, @item.done
  end

  test "deletes an item" do
    assert_difference("Item.count", -1) do
      delete "/todos/#{@todo.id}/items/#{@item.id}",
             headers: auth_headers
    end

    assert_response :success
  end

  test "returns not found for unknown item" do
    get "/todos/#{@todo.id}/items/999999",
        headers: auth_headers

    assert_response :not_found
  end

  test "rejects request without authentication token" do
    get "/todos/#{@todo.id}/items/#{@item.id}"

    assert_response :unauthorized
  end

  private

  def auth_headers
    {
      "Authorization" => "Bearer #{@token}"
    }
  end
end