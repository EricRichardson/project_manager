class DiscussionsController < ApplicationController
  before_action :find_project
  before_action :find_discussion, only: [:show, :edit, :update, :destroy]

  before_action :authenticate_user!, except: [:show, :index]

  def new
    @discussion = Discussion.new
  end

  def create
    discussion = Discussion.new discussion_params
    discussion.project = @project
    discussion.user = current_user
    if discussion.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  def show
    @comments = @discussion.comments.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @discussion.update discussion_params
      redirect_to project_discussion_path(@project, @discussion), notice: "Project updated!"
    else
      flash[:alert] = "Error in the update"
      render :edit
    end
  end

  def destroy
    @discussion.destroy
    redirect_to project_path(@project), notice: "Discussion deleted"
  end

  private

    def find_project
      @project = Project.find params[:project_id]
    end

    def find_discussion
      @discussion = Discussion.find params[:id]
    end

    def discussion_params
      params.require(:discussion).permit(:title, :description)
    end
end
