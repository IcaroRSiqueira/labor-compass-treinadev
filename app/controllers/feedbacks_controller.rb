class FeedbacksController < ApplicationController
  before_action :authenticate_headhunter!

  def decline
    @entry = Entry.find(params[:id])
    @feedback = @entry.create_feedback(feedback_params)
     if @feedback.save
       @entry.rejected!
       redirect_to registered_entries_path, notice: "Candidato rejeitado com \
sucesso"
     else
       redirect_to registered_entries_path, notice: "Erro(s): \
#{(@feedback.errors.full_messages.each {|m| m}).join}"
     end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:body)
  end
end
