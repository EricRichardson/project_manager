class ProjectsController < ApplicationController
  def index
    @projects = Project.order(created_at: :desc)
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    if @project.save
      redirect_to project_path @project
    else
      render :new
    end

  end

  def show
    @project = project
  end

  def edit
    @project = project
  end

  def destroy
    @project = project
    @project.destroy
    redirect_to projects_path
  end

  private

    def project
      Project.find params[:id]
    end

    def project_params
      params.require(:project).permit(:title, :description, :due_date)
    end
end
