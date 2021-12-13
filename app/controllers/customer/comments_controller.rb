class Customer::CommentsController < ApplicationController
  before_action :authenticate_customer!

  def create
      comment = Comment.new(comment_params)
      comment.save
      redirect_to request.referer
  end

  def destroy
      comment = Comment.find(params[:comment_id])
      comment.destroy
      redirect_to request.referer
  end

private

  def comment_params
    params.require(:comment).permit(:customer_id, :explanation_id, :comment)
  end

end
