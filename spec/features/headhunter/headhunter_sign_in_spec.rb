require 'rails_helper'

feature 'Headhunter sign in' do
  scenario 'from home page' do
    headhunter = create(:headhunter)

    visit root_path

    click_on 'Entrar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password

    within ('form') do
      click_on 'Log in'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content("Login efetuado com sucesso")
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar como Headhunter'
  end

  scenario 'Headhunter sign out' do
    headhunter = create(:headhunter)

    visit root_path

    click_on 'Entrar como Headhunter'

    fill_in 'Email', with: headhunter.email
    fill_in 'Senha', with: headhunter.password

    click_on 'Log in'
    click_on 'Sair'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Logout efetuado com sucesso')
    expect(page).to have_link 'Entrar como Headhunter'
    expect(page).not_to have_link 'Sair'
  end
end
