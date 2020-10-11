class BoardsController < ApplicationController
  before_action :logged_in_user, only: [:create]

  def index
    @boards = Board.paginate(page: params[:page], per_page: 10)
  end

  def new
    @board = Board.new
  end

  def create
    @board = Board.new(user_id: current_user.id,
                       title: params[:board][:title])
    if @board.save
      flash[:success] = "スレッドが作成されました！"
      redirect_to board_url(@board)
    else
      render 'new'
    end
  end

  def show
    @board = Board.includes(:board_comments).find(params[:id])
    @board_comment = BoardComment.new
  end

  def edit
    @board = Board.find(params[:id])
  end

  def update
    if @board = Board.find(params[:id])
      @board.update_attributes(boards_params_update)
      flash[:success] = "タイトルが更新されました！"
      redirect_to @board
    else
      render 'edit'
    end
  end

  def destroy
    @board = Board.find(params[:id])
    if current_user.id == @board.user_id || current_user.admin?
      @board.destroy
      flash[:success] = "掲示板の削除に成功しました"
      redirect_to boards_url
    else
      flash[:danger] = "他人のアカウントは削除できません"
      render "/boards"
    end
  end

  private

    def boards_params
      params.require(:board).permit(:title, :user_id)
    end

    def boards_params_update
      params.require(:board).permit(:title)
    end
end
