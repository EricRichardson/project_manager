class ProjectsController < ApplicationController
  before_action :find_project, only: [:show, :edit, :update, :destroy]

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    @project.user = current_user
    if @project.save
      redirect_to project_path @project
    else
      render :new
    end
  end

  def index
    @projects = Project.order(created_at: :desc)
  end

  def show
    @discussions = @project.discussions.order(created_at: :desc)
    @tasks = @project.tasks.order(:created_at)
  end

  def edit
  end

  def update
    if @project.update project_params
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to project_path(@project)
  end

  private

    def find_project
      @project = Project.find params[:id]
    end

    def project_params
      params.require(:project).permit(:title, :description, :due_date)
    end
end
