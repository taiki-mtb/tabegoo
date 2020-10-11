class BoardCommentsController < ApplicationController
  before_action :logged_in_user

  def create
    @board = Board.find(params[:board_id])
    @board_comment = @board.board_comments.build(user_id: current_user.id,
                                                 content: params[:board_comment][:content])
    if !@board.nil? && @board_comment.save
      flash[:success] = "コメントを追加しました！"
    else
      flash[:danger] = "空のコメントは投稿できません。"
    end
    redirect_to request.referrer || root_url
  end

  def destroy
    @board_comment = BoardComment.find(params[:id])
    @board = @board_comment.board
    if current_user.id == @board_comment.user_id || current_user.admin?
      @board_comment.destroy
      flash[:success] = "コメントを削除しました"
    end
    redirect_to board_url(@board)
  end
end
