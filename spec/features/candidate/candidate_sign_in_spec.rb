require 'rails_helper'

feature 'Candidate sign in' do
  scenario 'from home page' do
    candidate = create(:candidate)

    visit root_path

    click_on 'Entrar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password

    within ('form') do
      click_on 'Log in'
    end

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Login efetuado com sucesso')
    expect(page).to have_link 'Sair'
    expect(page).not_to have_link 'Entrar como Candidato'
  end

  scenario 'Candidate sign out' do
    candidate = create(:candidate)

    visit root_path

    click_on 'Entrar como Candidato'

    fill_in 'Email', with: candidate.email
    fill_in 'Senha', with: candidate.password

    click_on 'Log in'
    click_on 'Sair'

    expect(current_path).to eq(root_path)
    expect(page).to have_content('Logout efetuado com sucesso')
    expect(page).to have_link 'Entrar como Candidato'
    expect(page).not_to have_link 'Sair'
  end
end
