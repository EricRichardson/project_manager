class TasksController < ApplicationController
  before_action :find_project
  before_action :find_task, only: [:show, :update, :destroy, :edit]

  before_action :authenticate_user!, except: [:show, :index]
  def new
    @task = Task.new
  end

  def create
    @task = Task.new task_params
    @task.project = @project
    @task.user = current_user
    respond_to do |format|
      if @task.save
        format.html {redirect_to project_path(@project)}
        format.js {render :task_success}
      else
        format.html {render :new}
        format.js {render :task_failure }
      end
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
    respond_to do |format|
      format.html {redirect_to project_path(@project)}
      format.js {render}
    end
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
