class TodosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_todo, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:toggle_status]


  # List all todos
  def index
    # Fetch all todos excluding those that were ticked more than 40 days ago
    @todos = Todo.where('status = ? OR (status = ? AND completed_at > ?)', false, true, 40.days.ago)

    @todos = @todos.sort_by { |todo|
      [
        todo.status ? 1 : 0,
        todo.status ? -todo.completed_at.to_i : -todo.priority,
        -todo.created_at.to_i
      ]
    }
  end


  # Display a form for a new todo
  def new
    @todo = Todo.new
  end

  # Create a new todo from form data
  def create
    @todo = current_user.todos.build(todo_params)
    if @todo.save
      redirect_to todos_path, notice: 'Todo was successfully created.'
    else
      render :new
    end
  end

  # Display a specific todo
  def show; end

  # Display a form to edit an existing todo
  def edit; end

  # Update a specific todo from form data
  def update
    if @todo.update(todo_params)
      redirect_to todos_path, notice: 'Todo was successfully updated.'
    else
      render :edit
    end
  end

  # Delete a specific todo
  def destroy
    @todo.destroy
    redirect_to todos_path, notice: 'Todo was successfully deleted.'
  end

  def toggle_status
    @todo = Todo.find(params[:id])
    @todo.update(status: !@todo.status)
    redirect_to todos_path, notice: 'Todo status was successfully updated.'
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :priority, :status)
  end
end
