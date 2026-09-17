class TodosController < ApplicationController
  before_action :set_todo, only: [:show, :update, :destroy]

  def index
    todos = current_user.todos.includes(:items)

    render json: todos.as_json(include: :items)
  end

  def show
    render json: @todo.as_json(include: :items)
  end

  def create
    todo = current_user.todos.build(todo_params)
    todo.created_by = current_user.id

    if todo.save
      render json: todo, status: :created
    else
      render json: { errors: todo.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: { errors: @todo.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy

    render json: {
      message: "Todo deleted successfully"
    }, status: :ok
  end

  private

  def set_todo
    @todo = current_user.todos.find_by(id: params[:id])

    unless @todo
      render json: { error: "Todo not found" }, status: :not_found
    end
  end

  def todo_params
    params.permit(:title)
  end
end