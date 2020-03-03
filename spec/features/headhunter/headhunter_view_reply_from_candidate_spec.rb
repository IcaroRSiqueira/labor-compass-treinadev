require 'rails_helper'

feature 'Candidate accept proposal' do
  scenario 'from home page' do
    headhunter = create(:headhunter)
    candidate = create(:candidate, email: 'test1@test.com', status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva')
    candidate2 = create(:candidate, email: 'test2@test.com', status: :complete)
    create(:profile, candidate: candidate2, social_name: 'Jose Silva')
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    vacancy2 = create(:vacancy, headhunter: headhunter, title: 'Lider de Vendas')
    entry = create(:entry, candidate: candidate, vacancy: vacancy)
    entry2 = create(:entry, candidate: candidate2, vacancy: vacancy2)
    proposal = create(:proposal, entry: entry, candidate: candidate, headhunter: headhunter, status: :refused)
    proposal2 = create(:proposal, entry: entry2, candidate: candidate2, headhunter: headhunter, status: :accepted)
    create(:report, proposal: proposal, body: 'Infelizmente a minha expecativa de salario esta acima da oferecida')
    create(:report, proposal: proposal2, body: 'Telefone para contato: (00) 0-0000-0000)')


    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Minhas propostas'

    expect(page).to have_content("Status: Proposta aceita")
    expect(page).to have_content("Status: Proposta recusada")
    expect(page).to have_content("Telefone para contato: (00) 0-0000-0000")
    expect(page).to have_content("Infelizmente a minha expecativa de salario esta acima da oferecida")
    expect(page).not_to have_content("Status: Aguardando resposta")
  end
end
