class CommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @restaurant = Restaurant.find(params[:restaurant_id])
    @comment = @restaurant.comments.build(user_id: current_user.id,
                                          content: params[:comment][:content])
    if !@restaurant.nil? && @comment.save
      flash[:success] = "コメントを追加しました！"
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @comment = Comment.find(params[:id])
    @restaurant = @comment.restaurant
    if current_user.id == @comment.user_id || current_user.admin?
      @comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to restaurant_url(@restaurant)
  end
end
