class UsersController < ApplicationController
  include ApplicationHelper
  before_action :logged_in_user, only: [:index, :show, :edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "ポートフォリオへようこそ！"
      redirect_to @user
    else
      render 'new'
    end
  end

  def omniauth # log users in with omniauth
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.valid?
      log_in user
      flash[:success] = "ポートフォリオへようこそ！"
      redirect_to user_path(user)
    else
      flash[:danger] = user.errors.full_messages.join(", ")
      redirect_to new_user_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params_update)
      flash[:success] = "プロフィールが更新されました！"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if current_user.admin?
      @user.destroy
      flash[:success] = "ユーザーの削除に成功しました"
      redirect_to users_url
    elsif current_user?(@user)
      @user.destroy
      flash[:success] = "自分のアカウントを削除しました"
      redirect_to root_url
    else
      flash[:danger] = "他人のアカウントは削除できません"
      redirect_to root_url
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation, :sex, :check_in,
                                   :uid, :provider)
    end

    def user_params_update
      params.require(:user).permit(:name, :email, :sex, :check_in)
    end

    def correct_user
      @user = User.find(params[:id])
      if !current_user?(@user)
        flash[:danger] = "このページへはアクセスできません"
        redirect_to(root_url)
      end
    end
end
