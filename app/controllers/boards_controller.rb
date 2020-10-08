class BoardsController < ApplicationController
	def index
		@boards = Board.all
	end

	def new
		@board = Board.new
	end

	def create
		@board = Board.new(user_id: current_user.id,
			                  title: params[:title])
		if @board.save
			flash[:success] = "スレッドが作成されました！"
			redirect_to "/boards"
		else
			render 'boards/new'
		end
	end

	private

	  def boards_params
	  	params.permit(:title, :user_id)
	  end
end
