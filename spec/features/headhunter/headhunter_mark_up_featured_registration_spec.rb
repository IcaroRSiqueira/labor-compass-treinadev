require 'rails_helper'

feature 'Headhunter mark up featured registration' do
  scenario 'from home page' do
    headhunter = create(:headhunter)
    vacancy = create(:vacancy, headhunter: headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva')
    create(:entry, candidate: candidate, vacancy: vacancy, description: 'Não possuo experiência')

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Aplicaçōes recebidas'
    click_on 'Marcar perfil como destaque'

    expect(page).to have_content("Perfil marcado como destaque")
    expect(page).to have_content("Não possuo experiência")
    expect(page).to have_content("⭐")
    expect(page).not_to have_link("Marcar perfil como destaque")

  end

  scenario 'headhunter unmark featured candidate' do
    headhunter = create(:headhunter)
    vacancy = create(:vacancy, headhunter: headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva')
    create(:entry, candidate: candidate, vacancy: vacancy, description: 'Não possuo experiência', label: :featured)


    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Aplicaçōes recebidas'
    click_on 'Desmarcar destaque'

    expect(page).to have_content("Destaque removido")
    expect(page).to have_content("Leticia Silva")
    expect(page).to have_content("Não possuo experiência")
    expect(page).not_to have_content("⭐")
    expect(page).not_to have_content("Desmarcar destaque")
    expect(page).to have_link("Marcar perfil como destaque")
  end
end
