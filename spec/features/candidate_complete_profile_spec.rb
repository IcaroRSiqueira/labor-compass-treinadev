require 'rails_helper'

feature 'Candidate complete profile' do
  scenario 'from home page' do
    candidate = Candidate.create!(email: 'test@test.com', password: '123456')

    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Completar perfil'

    fill_in 'Nome completo', with: 'Jose Fulano'
    fill_in 'Nome social', with: 'Josias Sicrano'
    fill_in 'Data de nascimento', with: '22/03/1975'
    fill_in 'Formação acadêmica', with: 'Bacharelado em física'
    fill_in 'Descrição', with: 'Realizado na USP em 2009'
    fill_in 'Experiências profissionais', with: 'Professor do estado 2012-2015'
    attach_file("Imagem de perfil", Rails.root + "spec/support/nyan.jpg")

    within ('form') do
      click_on 'Registrar perfil'
    end

    expect(page).to have_content("Perfil cadastrado com sucesso!")
    expect(page).to have_content ('Jose Fulano')
    expect(page).to have_content ('Josias Sicrano')
    expect(page).to have_content ('22/03/1975')
    expect(page).to have_content ('Bacharelado em física')
    expect(page).to have_content ('Realizado na USP em 2009')
    expect(page).to have_content ('Professor do estado 2012-2015')
    expect(page).to have_xpath("//img[contains(@src,'nyan.jpg')]")
    expect(page).to have_link ('Meu perfil')
    expect(page).not_to have_link ('Completar perfil')
  end

  scenario 'candidate gets redirected to new profile when not completed' do
    candidate = Candidate.create!(email: 'test@test.com', password: '123456')

    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Vagas disponíveis'


    expect(current_path).to eq new_profile_path
    expect(page).to have_content ('Complete seu perfil para ter acesso a todas as funcionalidades')
  end

  scenario 'candidate edit profile' do
    candidate = Candidate.create!(email: 'test@test.com', password: '123456', status: :complete)
    profile = Profile.create!(full_name: 'Junior Silva', social_name: 'Leticia Silva',
                              birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                              description: 'Curso finalizado em 2010',
                              experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate)
    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Meu perfil'
    click_on 'Editar perfil'

    fill_in 'Formação acadêmica', with: 'Graduação em ADS pela USP e pós doutorado em ciências de dados'
    attach_file("Imagem de perfil", Rails.root + "spec/support/nyan.jpg")

    within ('form') do
      click_on 'Registrar perfil'
    end

    expect(page).to have_content("Perfil alterado com sucesso!")
    expect(page).to have_content ('Junior Silva')
    expect(page).to have_content ('Leticia Silva')
    expect(page).to have_content ('13/12/1985')
    expect(page).to have_content ('Graduação em ADS pela USP e pós doutorado em ciências de dados')
    expect(page).to have_content ('Curso finalizado em 2010')
    expect(page).to have_content ('5 anos de desenvolvimento front end em ruby e java')
    expect(page).to have_xpath("//img[contains(@src,'nyan.jpg')]")
  end

  scenario 'must fill in obrigatory fields' do
    candidate = Candidate.create!(email: 'test@test.com', password: '123456')

    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Completar perfil'

    fill_in 'Nome completo', with: ''
    fill_in 'Nome social', with: 'Josias Sicrano'
    fill_in 'Data de nascimento', with: ''
    fill_in 'Formação acadêmica', with: 'Bacharelado em física'
    fill_in 'Descrição', with: 'Realizado na USP em 2009'
    fill_in 'Experiências profissionais', with: 'Professor do estado 2012-2015'
    attach_file("Imagem de perfil", Rails.root + "spec/support/nyan.jpg")

    within ('form') do
      click_on 'Registrar perfil'
    end

    expect(page).to have_content('não pode ficar em branco')
    end
  end
