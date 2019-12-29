class EntriesController < ApplicationController

  def registered
    @entries = Entry.all
    @comment = Comment.new
    @candidate = current_candidate
  end

  def apply
    @vacancy = Vacancy.find(params[:id])
    @entry = Entry.create!(vacancy: @vacancy, candidate: current_candidate)
    @entry.avaiable!
    redirect_to registered_entries_path, notice: 'Cadastro realizado com sucesso!'
  end

  def feature
    @entry = Entry.find(params[:id])
    @entry.featured!
    redirect_to registered_entries_path, notice: 'Perfil marcado como destaque!'
  end

  def reject
    @entry = Entry.find(params[:id])
    @feedback = Feedback.new
  end

end
