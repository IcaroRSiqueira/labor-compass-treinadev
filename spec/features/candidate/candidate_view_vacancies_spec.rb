require 'rails_helper'
require 'time_helpers'

feature 'Candidate view vacancies' do
  scenario 'from home page' do

    headhunter = create(:headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate)
    create(:vacancy, headhunter: headhunter, title: 'Entregador', description: 'Realizar entregas',
                    skill: 'Possuir CNH A e B', wage: '2000', role: 'Pleno',
                    end_date: 10.day.from_now, location: 'Rua Augusta')
    create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista')
    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Vagas disponíveis'

    expect(page).to have_content("Entregador")
    expect(page).to have_content("Realizar entregas")
    expect(page).to have_content("Possuir CNH A e B")
    expect(page).to have_content("2000")
    expect(page).to have_content("Pleno")
    expect(page).to have_content(10.day.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content("Rua Augusta")
    expect(page).to have_content("Desenvolvedor Web")
    expect(page).to have_content("Desenvilvimento de paginas web com ruby on rails")
    expect(page).to have_content("Experiencia com ruby on rails")
    expect(page).to have_content("3000")
    expect(page).to have_content("Junior")
    expect(page).to have_content(15.day.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content("Av Paulista")
  end

  scenario 'no vacancies message' do

    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate)
    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Vagas disponíveis'

    expect(page).to have_content("Nenhuma vaga disponível no momento.")
  end
end
