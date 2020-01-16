require 'rails_helper'

feature 'Headhunter view candidates on vacancy' do
  scenario 'from home page' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate1 = Candidate.create!(email: 'test1@test.com', password: '123456', status: :complete)
    candidate2 = Candidate.create!(email: 'test2@test.com', password: '123456', status: :complete)
    candidate3 = Candidate.create!(email: 'test3@test.com', password: '123456', status: :complete)
    profile1 = Profile.create!(full_name: 'Junior Silva', social_name: 'Leticia Silva',
                              birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                              description: 'Curso finalizado em 2010',
                              experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate1)
    profile2 = Profile.create!(full_name: 'Jose Silva', social_name: 'Jose Silva',
                              birth_date: '12/12/1990', education: 'Graduação em ADS pela FMU',
                              description: 'Curso finalizado em 2015',
                              experience: '3 anos de desenvolvimento back end em ruby', candidate: candidate2)
    profile3 = Profile.create!(full_name: 'Maria Silva', social_name: 'Maria Silva',
                              birth_date: '12/05/1999', education: 'Ciencias da computaçao pela FMU',
                              description: 'Curso finalizado em 2013',
                              experience: 'Sem experiencia profissional', candidate: candidate3)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter)
    Entry.create!(candidate: candidate1, vacancy: vacancy,
                         description: 'Possuo bastante experiencia como desenvolvedor')
    Entry.create!(candidate: candidate2, vacancy: vacancy,
                         description: 'Possuo pouca experiencia como desenvolvedor')
    Entry.create!(candidate: candidate3, vacancy: vacancy,
                         description: 'Nao possuo experiencia mas sou proativa')
    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Aplicaçōes recebidas'

    expect(page).to have_content("Desenvolvedor Web")
    expect(page).to have_content("Junior Silva")
    expect(page).to have_content("Leticia Silva")
    expect(page).to have_content("13/12/1985")
    expect(page).to have_content("Graduação em ADS pela USP")
    expect(page).to have_content("Curso finalizado em 2010")
    expect(page).to have_content("5 anos de desenvolvimento front end em ruby e java")
    expect(page).to have_content("Possuo bastante experiencia como desenvolvedor")
    expect(page).to have_content("Jose Silva")
    expect(page).to have_content("12/12/1990")
    expect(page).to have_content("Graduação em ADS pela FMU")
    expect(page).to have_content("Curso finalizado em 2015")
    expect(page).to have_content("3 anos de desenvolvimento back end em ruby")
    expect(page).to have_content("Possuo pouca experiencia como desenvolvedor")
    expect(page).to have_content("Maria Silva")
    expect(page).to have_content("12/05/1999")
    expect(page).to have_content("Ciencias da computaçao pela FMU")
    expect(page).to have_content("Curso finalizado em 2013")
    expect(page).to have_content("Sem experiencia profissional")
    expect(page).to have_content("Nao possuo experiencia mas sou proativa")
  end

  scenario 'must not see entries of another headhunter' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    headhunter2 = Headhunter.create!(email: 'test2@test.com', password: '123456',
                                    name: 'Another Test INC')
    candidate1 = Candidate.create!(email: 'test1@test.com', password: '123456', status: :complete)
    candidate2 = Candidate.create!(email: 'test2@test.com', password: '123456', status: :complete)
    profile1 = Profile.create!(full_name: 'Junior Silva', social_name: 'Leticia Silva',
                              birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                              description: 'Curso finalizado em 2010',
                              experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate1)
    profile2 = Profile.create!(full_name: 'Jose Silva', social_name: 'Jose Silva',
                              birth_date: '12/12/1990', education: 'Graduação em processos gerenciais pela anhanguera',
                              description: 'Curso finalizado em 2010',
                              experience: 'Sem experiência', candidate: candidate2)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                              skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                              end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable)
    vacancy2 = Vacancy.create!(title: 'Gerente de projetos', description: 'Gerenciar equipes em projetos',
                               skill: 'Experiencia com processos gerenciais', wage: '4500', role: 'Pleno',
                               end_date: 20.day.from_now, location: 'Av Rebouças', headhunter: headhunter2, status: :avaiable)
    Entry.create!(candidate: candidate1, vacancy: vacancy,
                  description: 'Possuo bastante experiencia como desenvolvedor')
    Entry.create!(candidate: candidate2, vacancy: vacancy2,
                  description: 'Nao possuo experiencia mas sou proativa')
    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Aplicaçōes recebidas'

    expect(page).to have_content("Desenvolvedor Web")
    expect(page).to have_content("Junior Silva")
    expect(page).to have_content("Leticia Silva")
    expect(page).to have_content("13/12/1985")
    expect(page).to have_content("Graduação em ADS pela USP")
    expect(page).to have_content("Curso finalizado em 2010")
    expect(page).to have_content("5 anos de desenvolvimento front end em ruby e java")
    expect(page).to have_content("Possuo bastante experiencia como desenvolvedor")
    expect(page).not_to have_content("Jose Silva")
    expect(page).not_to have_content("12/12/1990")
    expect(page).not_to have_content("Graduação em processos gerenciais pela anhanguera")
    expect(page).not_to have_content("Curso finalizado em 2015")
    expect(page).not_to have_content("Sem experiência")
    expect(page).not_to have_content("Nao possuo experiencia mas sou proativa")
  end
end
