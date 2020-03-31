require 'rails_helper'

feature 'Candidate view feedback from refused vacancy' do
  scenario 'from home page' do
    headhunter = create(:headhunter, name: 'Teste Enterprises')
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    entry = create(:entry, candidate: candidate, vacancy: vacancy,
                            status: :rejected)
    create(:feedback, entry: entry, body: 'O perfil não supriu as necessidades')

    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Minhas vagas'

    expect(page).to have_content("Status: Recusada")
    expect(page).to have_content("O perfil não supriu as necessidades")
    expect(page).to have_content("Teste Enterprises")
  end
end
