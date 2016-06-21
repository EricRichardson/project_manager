class PasswordResetsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email (params[:email])
    if user
      token = SecureRandom.urlsafe_base64
      user.update reset_token: token
      url = edit_password_reset_url(user) + "/?token=#{token}"
      PasswordResetMail.send_reset(user, url).deliver_now
      redirect_to root_path, notice: "Reset Email sent!"
    else
      flash[:alert] = "Email not found"
      render :new
    end
  end

  def edit
    @token = params[:token]
  end

  def update
    user = User.find params[:id]
    if (user.reset_token == params[:token]) && (params[:new_password] == params[:new_password_confirmation])
      user.update password: params[:new_password]
      redirect_to root_path, notice: "Password reset"
    else
      flash[:alert] = "Error! Password was not reset"
      render :new
    end
  end
end
