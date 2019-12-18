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
  end
