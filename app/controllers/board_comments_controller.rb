class BoardCommentsController < ApplicationController
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

  private

    def params_board_comment
    	params.require(:board_comment).permit(:user_id, :content)
    end
end
