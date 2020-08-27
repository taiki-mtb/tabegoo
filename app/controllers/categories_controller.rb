class CategoriesController < ApplicationController
 def create
  @salon = current_salon
　　　　@category = @salon.categoies.build(category_params)
  if @salon.save
    flash[:success] = "カテゴリーを登録しました"
    redirect_to root_url
  else
    flash[:danger] = "カテゴリーが登録できませんでした"
    redirect_to root_url

　　　private
   def category_params
     params.require(:category).permit(:name)
   end
end