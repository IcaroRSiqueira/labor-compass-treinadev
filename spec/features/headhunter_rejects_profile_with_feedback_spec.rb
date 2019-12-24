require 'rails_helper'

feature 'Headhunter view candidates on vacancy' do
  scenario 'from home page' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate1 = Candidate.create!(email: 'test1@test.com', password: '123456', status: :complete)
    profile1 = Profile.create!(full_name: 'Junior Silva', social_name: 'Leticia Silva',
                              birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                              description: 'Curso finalizado em 2010',
                              experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate1)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter)
    Registration.create!(candidate: candidate1, vacancy: vacancy,
                         description: 'Possuo bastante experiencia como desenvolvedor')

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Aplicaçōes recebidas'
    click_on 'Rejeitar participação'
    fill_in 'Feedback ao candidato', with: 'Infelizmente o perfil não supriu as necessidades da vaga'
    click_on 'Enviar feedback'

    expect(page).to have_content("Candidato rejeitado com sucesso")
    expect(page).to have_content("Infelizmente o perfil não supriu as necessidades da vaga")
    expect(page).to have_content("Desenvolvedor Web")
    expect(page).to have_content("Junior Silva")
    expect(page).not_to have_link("Rejeitar participação")
    expect(page).not_to have_link("Marcar perfil como destaque")
  end
end
