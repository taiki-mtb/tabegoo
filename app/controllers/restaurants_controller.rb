class RestaurantsController < ApplicationController
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

  private

    def restaurant_params
      params.require(:restaurant).permit(:name, :description)
    end
end
