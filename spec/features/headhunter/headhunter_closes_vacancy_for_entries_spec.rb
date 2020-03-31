require 'rails_helper'

feature 'Headhunter closes vacancy' do
  scenario 'from home page' do
    headhunter = create(:headhunter)
    vacancy = create(:vacancy, title: 'Motorista de limosine',
                                headhunter: headhunter)
    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Minhas vagas'
    click_on vacancy.title
    click_on 'Encerrar inscrições para esta vaga'

    expect(page).to have_content("Vaga encerrada com sucesso")
    expect(page).to have_content("Motorista de limosine")
    expect(page).to have_content("Status: Inscrições encerradas")
    expect(page).not_to have_content("Status: Inscrições abertas")
  end

  scenario 'candidate view closed vacancy' do
    candidate = create(:candidate, status: :complete)
    create(:vacancy, status: :finalized)
    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Vagas disponíveis'

    expect(page).to have_content("Nenhuma vaga disponível no momento")
    expect(page).not_to have_content("Desenvolvedor Web")
  end
end
