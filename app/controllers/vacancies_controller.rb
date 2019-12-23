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
    @vacancy = Vacancy.new(vacancy_params)
    if @vacancy.save
      redirect_to @vacancy, notice: 'Vaga cadastrada com sucesso'
    else
      render :new
    end
  end

  def apply
    @vacancy = Vacancy.find(params[:id])
    @registration = Registration.create!(vacancy: @vacancy, candidate: current_candidate)
    redirect_to registered_vacancies_path, notice: 'Cadastro realizado com sucesso!'
  end

  def registered
    @registrations = Registration.all
    @comment = Comment.new
    @candidate = current_candidate
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
