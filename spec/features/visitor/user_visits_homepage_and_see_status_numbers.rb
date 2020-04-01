require 'rails_helper'

feature 'Index counter' do
  scenario '1 headhunter' do
    allow(HomeCalculator).to receive(:headhunters_count).and_return(1)

    visit root_path

    expect(page).to have_content("1 empresa(s) cadastrada(s)")
  end

  scenario '1 candidate' do
    allow(HomeCalculator).to receive(:candidates_count).and_return(1)

    visit root_path

    expect(page).to have_content("1 candidato(s) cadastrado(s)")
  end

  scenario '1 vacancy' do
    allow(HomeCalculator).to receive(:avaiable_vacancies_count).and_return(1)

    visit root_path

    expect(page).to have_content("1 vaga(s) disponível(is)")
  end

  scenario 'vacancy entry average 15' do
    allow(HomeCalculator).to receive(:number_of_applies_for_vacancies)
      .and_return(15)

    visit root_path

    expect(page).to have_content("Em média, cada vaga cadastrada recebe 15 \
aplicaçōes")
  end

  scenario 'average proposal to entry 33.3' do
    allow(HomeCalculator).to receive(:percentage_of_proposals_from_apllies)
      .and_return(33)

    visit root_path

    expect(page).to have_content("Em média, 33% das aplicaçōes recebem \
propostas!")
  end
end
