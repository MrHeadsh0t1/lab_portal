require "test_helper"

class TodosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(
      name: "Todo User",
      email: "todouser@test.com",
      password: "123456"
    )

    @token = @user.auth_token

    @todo = @user.todos.create!(
      title: "Existing Todo",
      created_by: @user.id
    )
  end

  test "gets all todos" do
    get "/todos",
        headers: auth_headers

    assert_response :success

    body = JSON.parse(response.body)

    assert_equal 1, body.length
    assert_equal "Existing Todo", body.first["title"]
    assert body.first.key?("items")
  end

  test "creates a todo" do
    assert_difference("Todo.count", 1) do
      post "/todos",
           params: { title: "New Todo" },
           headers: auth_headers
    end

    assert_response :created

    body = JSON.parse(response.body)

    assert_equal "New Todo", body["title"]
    assert_equal @user.id, body["user_id"]
  end

  test "gets a todo" do
    get "/todos/#{@todo.id}",
        headers: auth_headers

    assert_response :success

    body = JSON.parse(response.body)

    assert_equal @todo.id, body["id"]
    assert_equal "Existing Todo", body["title"]
  end

  test "updates a todo" do
    put "/todos/#{@todo.id}",
        params: { title: "Updated Todo" },
        headers: auth_headers

    assert_response :success

    @todo.reload
    assert_equal "Updated Todo", @todo.title
  end

  test "deletes a todo" do
    assert_difference("Todo.count", -1) do
      delete "/todos/#{@todo.id}",
             headers: auth_headers
    end

    assert_response :success
  end

  test "rejects request without authentication token" do
    get "/todos"

    assert_response :unauthorized
  end

  test "returns not found for unknown todo" do
    get "/todos/999999",
        headers: auth_headers

    assert_response :not_found
  end

  private

  def auth_headers
    {
      "Authorization" => "Bearer #{@token}"
    }
  end
end