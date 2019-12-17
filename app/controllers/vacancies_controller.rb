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

  def destroy
    @vacancy = Vacancy.find(params[:id])
    @vacancy.destroy
    redirect_to vacancies_path
  end

  private

  def vacancy_params
  params.require(:vacancy).permit(:title, :description, :skill, :wage, :role,
                                  :end_date, :location)
  end
end
