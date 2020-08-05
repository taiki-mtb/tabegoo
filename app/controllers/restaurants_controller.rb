class RestaurantsController < ApplicationController
  def new
    if current_user.admin?
      @restaurant = Restaurant.new
    else
      flash[:danger] = "管理人しか作成できません"
      redirect_to root_url
    end
  end
end
