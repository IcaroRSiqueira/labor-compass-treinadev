require 'rails_helper'

feature 'candidate search vacancy' do
  scenario 'successfully' do
    headhunter = create(:headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate)
    create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    create(:vacancy, headhunter: headhunter, title: 'Motorista')

    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Vagas disponíveis'
    fill_in 'Buscar vaga por título', with: 'Desenvolvedor'
    click_on 'Buscar'

    expect(page).to have_content('Desenvolvedor')
    expect(page).not_to have_content('Motorista')

  end

  scenario 'first letters only' do
    headhunter = create(:headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate)
    create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    create(:vacancy, headhunter: headhunter, title: 'Motorista')
    create(:vacancy, headhunter: headhunter, title: 'Medico')

    login_as(candidate, scope: :candidate)
    visit root_path

    click_on 'Vagas disponíveis'
    fill_in 'Buscar vaga por título', with: 'Desenv'
    click_on 'Buscar'

    expect(page).to have_content('Desenvolvedor')
    expect(page).not_to have_content('Motorista')
    expect(page).not_to have_content('Medico')
  end
end
