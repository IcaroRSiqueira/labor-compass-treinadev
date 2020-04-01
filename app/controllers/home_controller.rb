class HomeController < ApplicationController

  def index
    @n_of_headhunters = HomeCalculator.headhunters_count
    @n_of_candidates = HomeCalculator.candidates_count
    @avaiable_vacancies = HomeCalculator.avaiable_vacancies_count
    @apply_for_vacancy = HomeCalculator.number_of_applies_for_vacancies
    @percent_p_a = HomeCalculator.percentage_of_proposals_from_apllies
  end
end
