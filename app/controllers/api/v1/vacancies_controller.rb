class Api::V1::VacanciesController < Api::V1::ApiController

  def show
    @vacancy = Vacancy.find(params[:id])
    render json: @vacancy
  end
end
