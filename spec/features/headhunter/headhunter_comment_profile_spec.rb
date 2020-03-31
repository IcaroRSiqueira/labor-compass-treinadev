require 'rails_helper'

feature 'Headhunter comment profile' do
  scenario 'from home page' do
    headhunter = create(:headhunter)
    vacancy = create(:vacancy, headhunter: headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva')
    create(:entry, candidate: candidate, vacancy: vacancy,
                    description: 'Não possuo experiência')

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Aplicaçōes recebidas'
    fill_in 'Comente este perfil', with: "As competências satisfazem as \
exigências da vaga"
    click_on 'Enviar comentário'

    expect(page).to have_content("Comentário enviado")
    expect(page).to have_content("Leticia Silva")
    expect(page).to have_content("Não possuo experiência")
    expect(page).to have_content("As competências satisfazem as exigências \
da vaga")
  end

  scenario 'must fill body' do
    headhunter = create(:headhunter)
    vacancy = create(:vacancy, headhunter: headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva')
    create(:entry, candidate: candidate, vacancy: vacancy,
                    description: 'Não possuo experiência')

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Aplicaçōes recebidas'
    click_on 'Enviar comentário'

    expect(page).not_to have_content('Comentários do anunciante')
    expect(page).not_to have_content('Comentário enviado')
  end
end
