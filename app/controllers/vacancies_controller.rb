class VacanciesController < ApplicationController
  before_action :authenticate_headhunter!, only: [:new, :create, :edit, :update, :destroy, :finalize]
  before_action :redirect_candidate_to_new_profile, only: [:index, :show, :search]
  before_action :vacancy_expiration_show, only: [:show]
  before_action :vacancy_expiration_index, only: [:index]
  before_action :check_if_there_are_entries, only: [:destroy]


  def index
    @vacancies = Vacancy.all
  end

  def show
    @vacancy = Vacancy.find(params[:id])
    @entry = Entry.new
  end

  def new
    @vacancy = Vacancy.new
  end

  def create
    @vacancy = current_headhunter.vacancies.create(vacancy_params)
    if @vacancy.save
      @vacancy.avaiable!
      redirect_to @vacancy, notice: 'Vaga cadastrada com sucesso'
    else
      render :new
    end
  end

  def finalize
    @vacancy = Vacancy.find(params[:id])
    @vacancy.finalized!
    @vacancy.save
    redirect_to vacancies_path, notice: 'Vaga encerrada com sucesso'
  end

  def destroy
    @vacancy = Vacancy.find(params[:id])
    @vacancy.destroy
    redirect_to vacancies_path
  end

  def search
    @vacancies = Vacancy.where('title like ?', "%#{params[:q]}%")
    render :index
  end

  private

  def vacancy_params
  params.require(:vacancy).permit(:title, :description, :skill, :wage, :role,
                                  :end_date, :location)
  end

  def redirect_candidate_to_new_profile
    if candidate_signed_in?
      unless current_candidate.complete?
      redirect_to new_profile_path, notice: 'Complete seu perfil para ter acesso a todas as funcionalidades'
      end
    end
  end

  def vacancy_expiration_index
   @vacancies = Vacancy.all
   @vacancies.each do |vacancy|
     if Date.current > vacancy.end_date
       vacancy.finalized!
     end
   end
 end
 def vacancy_expiration_show
   @vacancy = Vacancy.find(params[:id])
   if Date.current > @vacancy.end_date
     @vacancy.finalized!
   end
 end

 def check_if_there_are_entries
   @vacancy = Vacancy.find(params[:id])
   if @vacancy.entries.any?
     flash[:notice] = 'Não é possível deletar uma vaga que ja possui aplicações'
     redirect_to vacancies_path
   end
 end
end
