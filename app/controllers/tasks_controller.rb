class TasksController < ApplicationController
  before_action :find_project
  before_action :find_task, only: [:show, :update, :destroy, :edit]
  def new
    @task = Task.new
  end

  def create
    @task = Task.new task_params
    @task.project = @project
    if @task.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @task.update task_params
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def index
    @tasks = Task.order(created_at: :desc)
  end

  def show
  end

  def destroy
    @task.destroy
    redirect_to project_path(@project)
  end

  private

  def find_task
    @task = Task.find params[:id]
  end

  def find_project
    @project = Project.find params[:project_id]
  end

  def task_params
    params.require(:task).permit(:title, :duedate, :completed)
  end
end
