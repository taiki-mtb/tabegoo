class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_back_or user
    else
      flash.now[:danger] = 'メールアドレスとパスワードの組み合わせが誤っています'
      render 'new'
    end
  end

  def omniauth  #log users in with omniauth
      user = User.from_omniauth(request.env['omniauth.auth'])
      if user.valid?
          log_in user
          flash[:success] = "ポートフォリオへようこそ！"
          redirect_to user_path(user)
      else
          flash[:message] = user.errors.full_messages.join(", ")
          redirect_to new_user_path
      end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
