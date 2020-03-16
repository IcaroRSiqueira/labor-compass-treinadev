require 'rails_helper'

feature 'Candidate accept proposal' do
  scenario 'from home page' do
    headhunter = create(:headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    vacancy2 = create(:vacancy, headhunter: headhunter, title: 'Motorista')
    entry = create(:entry, candidate: candidate, vacancy: vacancy)
    entry2 = create(:entry, candidate: candidate, vacancy: vacancy2)
    proposal = create(:proposal, entry: entry, candidate: candidate, headhunter: headhunter)
    proposal2 = create(:proposal, entry: entry2, candidate: candidate, headhunter: headhunter)
    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Propostas recebidas'
    click_on vacancy.title
    click_on 'Aceitar proposta'
    fill_in 'Mensagem adicional (opcional)', with: 'Telefone para contato: (00) 0-0000-0000'
    click_on 'Confirmar e aceitar proposta'

    expect(page).to have_content("Parabéns, você aceitou a proposta e já tem um novo emprego!")
    expect(page).to have_content("Status: Proposta aceita")
    expect(page).to have_content("Status: Proposta recusada")
    expect(page).to have_content("Telefone para contato: (00) 0-0000-0000")
    expect(page).not_to have_content("Status: Aguardando resposta")
  end

  scenario 'candidate rejects proposal' do
    headhunter = create(:headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    entry = create(:entry, candidate: candidate, vacancy: vacancy)
    proposal = create(:proposal, entry: entry, candidate: candidate, headhunter: headhunter)
    login_as(candidate, scope: :candidate)

    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Propostas recebidas'
    click_on vacancy.title
    click_on 'Rejeitar proposta'
    fill_in 'Mensagem adicional (opcional)', with: 'Infelizmente o salario nao é compativel com minha expectativa'
    click_on 'Confirmar rejeição da proposta'

    expect(page).to have_content("Proposta rejeitada com sucesso")
    expect(page).to have_content("Status: Proposta recusada")
    expect(page).to have_content("Infelizmente o salario nao é compativel com minha expectativa")
    expect(page).not_to have_content("Status: Proposta aceita")
    expect(page).not_to have_content("Status: Aguardando resposta")
  end

  scenario 'candidate returns to proposals index' do
    headhunter = create(:headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    entry = create(:entry, candidate: candidate, vacancy: vacancy)
    proposal = create(:proposal, entry: entry, candidate: candidate, headhunter: headhunter)

    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Propostas recebidas'
    click_on vacancy.title
    click_on 'Voltar'

    expect(current_path).to eq entry_proposals_path(candidate)
  end
end
