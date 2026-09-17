class ItemsController < ApplicationController
  before_action :set_todo
  before_action :set_item, only: [:show, :update, :destroy]

  def show
    render json: @item
  end

  def create
    item = @todo.items.build(item_params)

    if item.save
      render json: item, status: :created
    else
      render json: { errors: item.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      render json: @item
    else
      render json: { errors: @item.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def destroy
    @item.destroy

    render json: {
      message: "Item deleted successfully"
    }, status: :ok
  end

  private

  def set_todo
    @todo = current_user.todos.find_by(id: params[:todo_id])

    unless @todo
      render json: { error: "Todo not found" }, status: :not_found
    end
  end

  def set_item
    @item = @todo.items.find_by(id: params[:id])

    unless @item
      render json: { error: "Item not found" }, status: :not_found
    end
  end

  def item_params
    params.permit(:name, :done)
  end
end