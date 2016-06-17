class DiscussionsController < ApplicationController
  before_action :find_project, only: [:new, :create, :show]
  before_action :find_discussion, only: [:show]

  def new
    @discussion = Discussion.new
  end

  def create
    discussion = Discussion.new discussion_params
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
