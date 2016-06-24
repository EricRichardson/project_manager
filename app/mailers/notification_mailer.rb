class NotificationMailer < ApplicationMailer
  default from: 'driftingeric@gmail.com'

  def send_comment_mail(comment)
    @comment = comment
    @discussion = comment.discussion
    @project = @discussion.project
    @owner = @discussion.user
    mail(to: @owner.email, subject: "Some one left a comment...") if @owner
  end

end
