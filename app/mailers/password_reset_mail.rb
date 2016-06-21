class PasswordResetMail < ApplicationMailer
  default from: "driftingeric@gmail.com"

  def send_reset(user, url)
    @url = url
    mail(to: user.email, subject: "Project Manager Password Reset", template_name: "password_reset")
  end
end
