class CommentsController < ApplicationController
  before_action :find_project
  before_action :find_discussion
  before_action :find_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new comment_params
    @comment.discussion = @discussion
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        NotificationMailer.send_comment_mail(@comment).deliver_later
        format.html {redirect_to project_discussion_path(@project, @discussion)}
        format.js {render '/comments/new_comment'}
      else
        format.html{render :new}
        format.js {render 'new_comment_fail'}
      end
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
    respond_to do |format|
    format.html {redirect_to project_discussion_path(@project, @discussion)}
    format.js { render }
    end
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
