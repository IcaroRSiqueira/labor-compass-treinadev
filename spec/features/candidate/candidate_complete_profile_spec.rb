require 'rails_helper'

feature 'Candidate complete profile' do
  scenario 'from home page' do
    candidate = create(:candidate)
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
    candidate = create(:candidate)

    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Vagas disponíveis'


    expect(current_path).to eq new_profile_path
    expect(page).to have_content ('Complete seu perfil para ter acesso a todas as funcionalidades')
  end

  scenario 'candidate edit profile' do
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate, full_name: 'Junior Silva', social_name: 'Leticia Silva',
                              birth_date: '13/12/1985')
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
    expect(page).to have_xpath("//img[contains(@src,'nyan.jpg')]")
  end

  scenario 'must fill in obrigatory fields' do
    candidate = create(:candidate)

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

    expect(page).to have_content('Nome completo não pode ficar em branco')
    expect(page).to have_content('Data de nascimento não pode ficar em branco')
    end
  end
