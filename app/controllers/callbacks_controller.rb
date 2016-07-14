class CallbacksController < ApplicationController

  def github
    github_data = request.env['omniauth.auth']
    user = User.find_or_create_from_github github_data
    sign_in(user)
    redirect_to root_path, notice: "Signed in with Github"
  end
end
