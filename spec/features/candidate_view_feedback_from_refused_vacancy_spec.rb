require 'rails_helper'

feature 'Candidate view feedback from refused vacancy' do
  scenario 'from home page' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate = Candidate.create!(email: 'test1@test.com', password: '123456', status: :complete)
    profile = Profile.create!(full_name: 'Junior Silva', social_name: 'Leticia Silva',
                              birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                              description: 'Curso finalizado em 2010',
                              experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter)
    entry = Entry.create!(candidate: candidate, vacancy: vacancy,
                  description: 'Possuo bastante experiencia como desenvolvedor', status: :rejected)
    Feedback.create!(entry: entry, body: 'Infelizmente o perfil não supriu as necessidades da vaga')

    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Minhas vagas'

    expect(page).to have_content("Status: Recusada")
    expect(page).to have_content("Infelizmente o perfil não supriu as necessidades da vaga")
    expect(page).to have_content("Teste Enterprises")
  end
end
