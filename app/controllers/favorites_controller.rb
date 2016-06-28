class FavoritesController < ApplicationController

  before_action :authenticate_user!

  def create
    project = Project.find params[:project_id]
    fav = Favorite.create(user: current_user, project: project)
    if fav.save
      redirect_to project_path(project), notice: "Project favorited"
    else
      redirect_to project_path(project), alert: "An error has occured"
    end
  end

  def destroy
    fav = Favorite.find params[:id]
    project = Project.find params[:project_id]
    fav.destroy if can? :destroy, Favorite
    redirect_to project_path(project), notice: "Project unfavorited"
  end

  def index
    @projects = current_user.favorite_projects
  end
end
