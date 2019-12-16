require 'rails_helper'

feature 'Headhunter register account' do
  scenario 'from home page' do

    visit root_path

    click_on 'Entrar como Headhunter'
    click_on 'Inscreva-se aqui'

    fill_in 'Email', with: 'test@test.com'
    fill_in 'Nome da Empresa', with: 'Teste Enterprises'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirme sua senha', with: '123456'

    within ('form') do
      click_on 'Registrar'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Welcome! You have signed up successfully.")
    expect(page).to have_link ('Sair')
    expect(page).not_to have_link ('Entrar como Headhunter')
  end
end
