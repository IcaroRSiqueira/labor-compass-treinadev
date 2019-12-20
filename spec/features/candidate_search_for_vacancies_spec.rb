require 'rails_helper'

feature 'candidate search vacancy' do
  scenario 'successfully' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate = Candidate.create!(email: 'test@test.com', password: '123456')
    login_as(candidate, scope: :candidate)
    vacancy = Vacancy.create!(title: 'Entregador', description: 'Realizar entregas',
                    skill: 'Possuir CNH A e B', wage: '2000', role: 'Pleno',
                    end_date: 10.day.from_now, location: 'Rua Augusta', headhunter: headhunter)
    other_vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter)

    visit root_path

    click_on 'Vagas disponíveis'
    fill_in 'Buscar vaga por título', with: vacancy.title
    click_on 'Buscar'

    expect(page).to have_content(vacancy.title)
    expect(page).not_to have_content(other_vacancy.title)

  end

  scenario 'first letters only' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate = Candidate.create!(email: 'test@test.com', password: '123456')
    login_as(candidate, scope: :candidate)
    vacancy = Vacancy.create!(title: 'Entregador', description: 'Realizar entregas',
                    skill: 'Possuir CNH A e B', wage: '2000', role: 'Pleno',
                    end_date: 10.day.from_now, location: 'Rua Augusta', headhunter: headhunter)
    other_vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter)
    another_vacancy = Vacancy.create!(title: 'Medico Veterinario', description: 'Clinica geral',
                                    skill: 'Experiencia em clinica medica e cirurgias', wage: '1500', role: 'Senior',
                                    end_date: 3.day.from_now, location: 'Av Faria Lima', headhunter: headhunter)
    visit root_path

    click_on 'Vagas disponíveis'
    fill_in 'Buscar vaga por título', with: 'Desenv'
    click_on 'Buscar'

    expect(page).to have_content(other_vacancy.title)
    expect(page).not_to have_content(vacancy.title)
    expect(page).not_to have_content(another_vacancy.title)
  end
end
