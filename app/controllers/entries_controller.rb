class EntriesController < ApplicationController
  before_action :authenticate_headhunter!, only: [:feature, :unfeature, :reject]
  before_action :authenticate_candidate!, only: [:apply]

  def registered
    if candidate_signed_in?
      @candidate_entries = current_candidate.entry.all
    elsif headhunter_signed_in?
      current_headhunter.vacancies.each do |vacancy|
        @headhunter_entries = vacancy.entries
      end
    end
    @comment = Comment.new
    @candidate = current_candidate
  end

  def apply
    @vacancy = Vacancy.find(params[:id])
    @entry = Entry.create(entry_params)
    if @entry.save
      @entry.avaiable!
      redirect_to registered_entries_path, notice: "Cadastro realizado com \
sucesso!"
    else
      redirect_to @vacancy, notice: "Erro(s): \
#{(@entry.errors.full_messages.each {|m| m}).join}"
    end
  end

  def feature
    @entry = Entry.find(params[:id])
    @entry.featured!
    redirect_to registered_entries_path, notice: 'Perfil marcado como destaque!'
  end

  def unfeature
    @entry = Entry.find(params[:id])
    @entry.not_featured!
    redirect_to registered_entries_path, notice: 'Destaque removido'
  end

  def reject
    @entry = Entry.find(params[:id])
    @feedback = Feedback.new
  end

  def entry_params
    candidate = current_candidate
    params.require(:entry).permit(:description).merge(vacancy: @vacancy,
                                                      candidate: candidate)

  end

end
