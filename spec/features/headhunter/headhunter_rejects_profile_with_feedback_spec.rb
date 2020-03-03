require 'rails_helper'

feature 'Headhunter rejects candidates' do
  scenario 'from home page' do
    headhunter = create(:headhunter)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva')
    create(:entry, candidate: candidate, vacancy: vacancy)

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Aplicaçōes recebidas'
    click_on 'Rejeitar participação'
    fill_in 'Feedback ao candidato', with: 'Infelizmente o perfil não supriu as necessidades da vaga'
    click_on 'Enviar feedback'

    expect(page).to have_content("Candidato rejeitado com sucesso")
    expect(page).to have_content("Infelizmente o perfil não supriu as necessidades da vaga")
    expect(page).to have_content("Desenvolvedor")
    expect(page).to have_content("Leticia Silva")
    expect(page).not_to have_link("Rejeitar participação")
    expect(page).not_to have_link("Marcar perfil como destaque")
  end

  scenario 'Must fill in feedback' do
    headhunter = create(:headhunter)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva')
    create(:entry, candidate: candidate, vacancy: vacancy)

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Aplicaçōes recebidas'
    click_on 'Rejeitar participação'
    fill_in 'Feedback ao candidato', with: ''
    click_on 'Enviar feedback'

    expect(page).not_to have_content("Candidato rejeitado com sucesso")
    expect(page).to have_content("Texto do feedback não pode ficar em branco")
  end
end
