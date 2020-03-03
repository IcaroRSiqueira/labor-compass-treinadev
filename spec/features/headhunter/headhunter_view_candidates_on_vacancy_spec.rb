require 'rails_helper'

feature 'Headhunter view candidates on vacancy' do
  scenario 'from home page' do
    headhunter = create(:headhunter)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    candidate = create(:candidate, email: 'test1@test.com', status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva', education: 'Graduação em ADS pela USP')
    create(:entry, candidate: candidate, vacancy: vacancy)
    candidate2 = create(:candidate, email: 'test2@test.com', status: :complete)
    create(:profile, candidate: candidate2, social_name: 'Jose Antonio', education: 'Eletronica pela ETEC')
    create(:entry, candidate: candidate2, vacancy: vacancy)
    candidate3 = create(:candidate, email: 'test3@test.com', status: :complete)
    create(:profile, candidate: candidate3, social_name: 'Maria Leite', education: 'Ciencias da computaçao pela FMU')
    create(:entry, candidate: candidate3, vacancy: vacancy)

    login_as(headhunter, scope: :headhunter)

    visit root_path
    click_on 'Aplicaçōes recebidas'

    expect(page).to have_content("Desenvolvedor")
    expect(page).to have_content("Leticia Silva")
    expect(page).to have_content("Graduação em ADS pela USP")
    expect(page).to have_content("Jose Antonio")
    expect(page).to have_content("Eletronica pela ETEC")
    expect(page).to have_content("Maria Leite")
    expect(page).to have_content("Ciencias da computaçao pela FMU")
  end

  scenario 'must not see entries of another headhunter' do
    headhunter = create(:headhunter)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    candidate = create(:candidate, email: 'test1@test.com', status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva', education: 'Graduação em ADS pela USP')
    create(:entry, candidate: candidate, vacancy: vacancy)
    headhunter2 = create(:headhunter, email: 'test2@test.com')
    vacancy2 = create(:vacancy, headhunter: headhunter2, title: 'Motorista')
    candidate2 = create(:candidate, email: 'test2@test.com', status: :complete)
    create(:profile, candidate: candidate2, social_name: 'Jose Antonio', education: 'CNH A e B')
    create(:entry, candidate: candidate2, vacancy: vacancy2)

    login_as(headhunter, scope: :headhunter)

    visit root_path
    click_on 'Aplicaçōes recebidas'

    expect(page).to have_content("Desenvolvedor")
    expect(page).to have_content("Leticia Silva")
    expect(page).not_to have_content("Jose Antonio")
    expect(page).not_to have_content("Motorista")
  end
end
