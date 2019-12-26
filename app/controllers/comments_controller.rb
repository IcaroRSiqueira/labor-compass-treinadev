class CommentsController < ApplicationController

  def post
    @entry = Entry.find(params[:id])
    @comment = @entry.comments.new(comments_params)
    @comment.comment_date = Date.current
    @comment.save!
    redirect_to registered_vacancies_path, notice: 'Comentário enviado'
  end
  private

  def comments_params
    params.require(:comment).permit(:body, :comment_date)
  end
end
