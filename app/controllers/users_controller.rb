class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :change_password, :update_password]
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      sign_in (@user)
      redirect_to root_path, notice: "Account made"
    else
      flash[:alert] = "Error in form"
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update user_params
      redirect_to edit_user_path(current_user), notice: "Update succesful"
    else
      flash[:alert] = "Error in form"
      render :edit
    end
  end

  def change_password
  end

  def update_password
    if @user.authenticate(params[:password]) && params[:new_password] == params[:new_password_confirmation]
      @user.update password: params[:new_password]
      redirect_to edit_user_path(current_user), notice: "New password saved!"
    else
      flash[:alert] = "Error in input"
      render :change_password
    end

  end
  private

    def find_user
      @user = User.find session[:user_id]
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation)
    end
end
