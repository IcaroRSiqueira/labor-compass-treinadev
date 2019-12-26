class FeedbacksController < ApplicationController

  def decline
    @entry = Entry.find(params[:id])
    @feedback = @entry.feedbacks.new(feedback_params)
    @feedback.save!
    @entry.rejected!
    redirect_to registered_vacancies_path, notice: 'Candidato rejeitado com sucesso'
  end

  private

  def feedback_params
    params.require(:feedback).permit(:body)
  end
end
