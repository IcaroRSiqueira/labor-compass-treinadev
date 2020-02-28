require 'rails_helper'

feature 'Headhunter closes vacancy' do
  scenario 'from home page' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate = Candidate.create!(email: 'test@test.com', password: '123456', status: :complete)
    profile = Profile.create!(full_name: 'Jose Silva', social_name: 'Jose Silva',
                              birth_date: '12/12/1990', education: 'Graduação em ADS pela FMU',
                              description: 'Curso finalizado em 2015',
                              experience: '3 anos de desenvolvimento back end em ruby', candidate: candidate)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter)
    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Minhas vagas'
    click_on vacancy.title
    click_on 'Encerrar inscrições para esta vaga'


    expect(page).to have_content("Vaga encerrada com sucesso")
    expect(page).to have_content("Desenvolvedor Web")
    expect(page).to have_content("Desenvilvimento de paginas web com ruby on rails")
    expect(page).to have_content("Status: Inscrições encerradas")
    expect(page).not_to have_content("Status: Inscrições abertas")
  end

  scenario 'candidate view closed vacancy' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate = Candidate.create!(email: 'test@test.com', password: '123456', status: :complete)
    profile = Profile.create!(full_name: 'Jose Silva', social_name: 'Jose Silva',
                              birth_date: '12/12/1990', education: 'Graduação em ADS pela FMU',
                              description: 'Curso finalizado em 2015',
                              experience: '3 anos de desenvolvimento back end em ruby', candidate: candidate)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :finalized)
    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Vagas disponíveis'


    expect(page).to have_content("Nenhuma vaga disponível no momento")
    expect(page).not_to have_content("Desenvolvedor Web")
  end
end
