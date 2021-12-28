class Customer::CommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
      @comment = Comment.new(comment_params)
      @comment.save
      #recipe = Recipe.find(params[:recipe_id])
      #byebug
      #@explanations = recipe.explanations.where(recipe_id: recipe.id)
      @comments = Comment.where(explanation_id: params[:explanation_id])
      @parent_explanation_id = params[:explanation_id]
      # redirect_to request.referer
  end

  def destroy
      @comment = Comment.find(params[:comment_id])
      @comment.destroy
      @comments = Comment.where(explanation_id: params[:explanation_id])
      @parent_explanation_id = params[:explanation_id]
  end

private

  def comment_params
    params.require(:comment).permit(:customer_id, :explanation_id, :comment)
  end

end
