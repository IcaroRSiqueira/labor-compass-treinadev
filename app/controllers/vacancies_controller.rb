class VacanciesController < ApplicationController
  before_action :authenticate_headhunter!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @vacancies = Vacancy.all
  end

  def show
    @vacancy = Vacancy.find(params[:id])
  end

  def new
    @vacancy = Vacancy.new
  end

  def create
    @vacancy = current_headhunter.vacancies.create(vacancy_params)
    if @vacancy.save
      redirect_to @vacancy, notice: 'Vaga cadastrada com sucesso'
    else
      render :new
    end
  end

  def apply
    @vacancy = Vacancy.find(params[:id])
    @entry = Entry.create!(vacancy: @vacancy, candidate: current_candidate)
    @entry.avaiable!
    redirect_to registered_vacancies_path, notice: 'Cadastro realizado com sucesso!'
  end

  def registered
    @entries = Entry.all
    @comment = Comment.new
    @candidate = current_candidate
  end

  def feature
    @entry = Entry.find(params[:id])
    @entry.featured!
    redirect_to registered_vacancies_path, notice: 'Perfil marcado como destaque!'
  end

  def reject
    @entry = Entry.find(params[:id])
    @feedback = Feedback.new
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
end
