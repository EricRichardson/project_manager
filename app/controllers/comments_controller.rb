class CommentsController < ApplicationController
  before_action :find_project
  before_action :find_discussion
  before_action :find_comment, only: [:edit, :update, :destroy]
  def new
    @comment = Comment.new
  end

  def create
    comment = Comment.new comment_params
    if comment.save
      redirect_to project_discussion_path(@project, @discussion)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @comment.update comment_params
      redirect_to project_discussion_path(@project, @discussion)
    else
      render :edit
    end
  end

  def destroy
    @comment.destroy
    redirect_to project_discussion_path(@project, @discussion)
  end

  private

    def comment_params
      params.require(:comment).permit(:body)
    end

    def find_comment
      @comment = Comment.find params[:id]
    end

    def find_project
      @project = Project.find params[:project_id]
    end

    def find_discussion
      @discussion = Discussion.find params[:discussion_id]
    end
end
