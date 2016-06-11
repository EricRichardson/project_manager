class TasksController < ApplicationController
  before_action :find_task, only: [:show, :update, :destroy, :edit]
  def show
  end

  def index
    @tasks = Task.order(created_at: :desc)
  end

  def edit
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new task_params
    if @task.save
      redirect_to task_path(@task)
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
  end

  private

  def find_task
    @task = Task.find params[:id]
  end

  def task_params
    params.require(:task).permit(:title, :due_date)
  end
end
