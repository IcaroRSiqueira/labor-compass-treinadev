require 'rails_helper'

feature 'Candidate view proposal' do
  scenario 'from home page' do
    headhunter = create(:headhunter, name: 'Teste Enterprises')
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva')
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    entry = create(:entry, candidate: candidate, vacancy: vacancy)
    create(:proposal, entry: entry, candidate: candidate,
                      headhunter: headhunter,
                      start_date: 20.day.from_now, workload: '9 as 17h',
                     benefits: 'Vale transporte e alimentação', wage: 'R$ 3000',
                     details: 'Desenvolvimento web')

    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Propostas recebidas'
    click_on vacancy.title

    expect(page).to have_content("Teste Enterprises")
    expect(page).to have_content("Leticia Silva")
    expect(page).to have_content(20.day.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content("9 as 17h")
    expect(page).to have_content("Vale transporte e alimentação")
    expect(page).to have_content("R$ 3000")
    expect(page).to have_content("Desenvolvimento web")
  end

  scenario 'candidate must not see proposals of another candidate' do
    headhunter = create(:headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate, social_name: 'Jose Silva')
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    entry = create(:entry, candidate: candidate, vacancy: vacancy,
                            status: :avaiable)
    create(:proposal, entry: entry, candidate: candidate,
                      headhunter: headhunter)
    candidate2 = create(:candidate, status: :complete, email: 'test@123')
    create(:profile, candidate: candidate2, social_name: 'Leticia Alves')
    entry2 = create(:entry, candidate: candidate2, vacancy: vacancy,
                            status: :avaiable)
    create(:proposal, entry: entry2, candidate: candidate2,
                      headhunter: headhunter)

    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Propostas recebidas'

    expect(page).to have_content("Desenvolvedor")
    expect(page).to have_content("Jose Silva")
    expect(page).not_to have_content("Leticia Alves")
  end
end
