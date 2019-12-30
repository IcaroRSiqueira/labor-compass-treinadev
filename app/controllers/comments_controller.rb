class CommentsController < ApplicationController
  before_action :authenticate_headhunter!

  def post
    @entry = Entry.find(params[:id])
    @comment = @entry.comments.new(comments_params)
    @comment.comment_date = Date.current
    if @comment.save
      redirect_to registered_entries_path, notice: 'Comentário enviado'
    else
      redirect_to registered_entries_path
    end
  end
  private

  def comments_params
    params.require(:comment).permit(:body, :comment_date)
  end
end
