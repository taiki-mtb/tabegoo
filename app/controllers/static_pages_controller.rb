class StaticPagesController < ApplicationController
  def home
    @feed_items = Restaurant.all.paginate(page: params[:page], per_page: 5)
  end
end
