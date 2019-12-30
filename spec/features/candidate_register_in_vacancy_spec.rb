require 'rails_helper'

feature 'Candidate register on vacancy' do
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
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable)
    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Vagas disponíveis'
    click_on vacancy.title
    fill_in 'Conte-nos mais sobre você!', with: 'Possuo 3 anos de experiência em desenvolvimento web com ruby'
    click_on 'Aplicar-se à vaga'


    expect(page).to have_content("Cadastro realizado com sucesso!")
    expect(page).to have_content("Minhas vagas")
    expect(page).to have_content("Desenvolvedor Web")
    expect(page).to have_content("Desenvilvimento de paginas web com ruby on rails")
    expect(page).to have_content("Experiencia com ruby on rails")
    expect(page).to have_content("3000")
    expect(page).to have_content("Junior")
    expect(page).to have_content(15.day.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content("Av Paulista")
  end

  scenario 'candidate cant register that was already applied by him' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate = Candidate.create!(email: 'test@test.com', password: '123456', status: :complete)
    profile = Profile.create!(full_name: 'Jose Silva', social_name: 'Jose Silva',
                              birth_date: '12/12/1990', education: 'Graduação em ADS pela FMU',
                              description: 'Curso finalizado em 2015',
                              experience: '3 anos de desenvolvimento back end em ruby', candidate: candidate)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable)
    entry = Entry.create!(candidate: candidate, vacancy: vacancy, status: :avaiable,
                          description: 'Possuo bastante experiencia como desenvolvedor')
    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Vagas disponíveis'
    click_on vacancy.title
    fill_in 'Conte-nos mais sobre você!', with: 'Possuo 3 anos de experiência em desenvolvimento web com ruby'
    click_on 'Aplicar-se à vaga'


    expect(page).not_to have_content("Cadastro realizado com sucesso!")
    expect(page).to have_content('Você ja se cadastrou para esta vaga')

  end

  scenario 'must fill in all fields' do
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
    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Vagas disponíveis'
    click_on vacancy.title
    fill_in 'Conte-nos mais sobre você!', with: ''
    click_on 'Aplicar-se à vaga'


      expect(page).to have_content('não pode ficar em branco')
      expect(page).to have_content('Conte-nos mais sobre você!')
  end
end
