class FeedbacksController < ApplicationController
  before_action :authenticate_headhunter!

  def decline
    @entry = Entry.find(params[:id])
    @feedback = @entry.create_feedback(feedback_params)
    @feedback.save!
    @entry.rejected!
    redirect_to registered_entries_path, notice: 'Candidato rejeitado com sucesso'
  end

  private

  def feedback_params
    params.require(:feedback).permit(:body)
  end
end
