require 'rails_helper'

feature 'Headhunter comment profile' do
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
    fill_in 'Comente este perfil', with: 'As competências satisfazem as exigências da vaga'
    click_on 'Enviar comentário'

    expect(page).to have_content("Comentário enviado")
    expect(page).to have_content("Desenvolvedor Web")
    expect(page).to have_content("Junior Silva")
    expect(page).to have_content("Leticia Silva")
    expect(page).to have_content("13/12/1985")
    expect(page).to have_content("Graduação em ADS pela USP")
    expect(page).to have_content("Curso finalizado em 2010")
    expect(page).to have_content("5 anos de desenvolvimento front end em ruby e java")
    expect(page).to have_content("Possuo bastante experiencia como desenvolvedor")
    expect(page).to have_content("As competências satisfazem as exigências da vaga")
  end
end
