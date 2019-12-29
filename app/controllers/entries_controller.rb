class EntriesController < ApplicationController

  def registered
    @entries = Entry.all
    @comment = Comment.new
    @candidate = current_candidate
  end

  def apply
    @vacancy = Vacancy.find(params[:id])
    @entry = Entry.create(entry_params)
    if @entry.save
      @entry.avaiable!
      @vacancy.invisible!
      redirect_to registered_entries_path, notice: 'Cadastro realizado com sucesso!'
    else
      redirect_to @vacancy, notice: "Você deve corrigir o(s) seguinte(s) erro(s): #{(@entry.errors.full_messages.each {|m| m}).join}"
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
    params.require(:entry).permit(:description).merge(vacancy: @vacancy, candidate: current_candidate)

  end

end
