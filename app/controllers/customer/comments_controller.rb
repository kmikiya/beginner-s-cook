class Customer::CommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
      @comment = Comment.new(comment_params)
      @comment.save

      recipe = Recipe.find(params[:recipe_id])
      @explanation = recipe.explanations.find_by(recipe_id: recipe.id)

      @parent_explanation_id = params[:explanation_id]
      # redirect_to request.referer
  end

  def destroy
     #@recipe = Recipe.find(params[:id])
      @comment = Comment.find(params[:comment_id])
      @comment.destroy
      recipe = Recipe.find(params[:recipe_id])
      @explanation = recipe.explanations.find_by(recipe_id: recipe.id)
      @parent_explanation_id = params[:explanation_id]
      #redirect_to request.referer
  end

private

  def comment_params
    params.require(:comment).permit(:customer_id, :explanation_id, :comment)
  end

end
