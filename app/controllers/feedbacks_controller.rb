class FeedbacksController < ApplicationController

  def decline
    @registration = Registration.find(params[:id])
    @feedback = @registration.feedbacks.new(feedback_params)
    @feedback.save!
    @registration.rejected!
    redirect_to registered_vacancies_path, notice: 'Candidato rejeitado com sucesso'
  end

  private

  def feedback_params
    params.require(:feedback).permit(:body)
  end
end
