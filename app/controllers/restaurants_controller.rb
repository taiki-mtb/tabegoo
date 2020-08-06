class RestaurantsController < ApplicationController
  before_action :correct_user, only: [:edit, :update]

  def new
    if logged_in? && current_user.admin?
      @restaurant = Restaurant.new
    else
      flash[:danger] = "管理人しか作成できません"
      redirect_to root_url
    end
  end

  def show
    @restaurant = Restaurant.find(params[:id])
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      flash[:success] = "レストランが登録されました！"
      redirect_to restaurant_path(@restaurant)
    else
      render 'restaurants/new'
    end
  end

  def edit
  end

  def update
    if @restaurant.update_attributes(restaurant_params)
      flash[:success] = "レストラン情報が更新されました！"
      redirect_to @restaurant
    else
      render 'edit'
    end
  end

  private

    def restaurant_params
      params.require(:restaurant).permit(:name, :description)
    end

    def correct_user
      if logged_in? && current_user.admin?
        @restaurant = Restaurant.find(params[:id])
      else
        flash[:danger] = "管理人しか編集できません"
        redirect_to root_path
      end
    end
end
