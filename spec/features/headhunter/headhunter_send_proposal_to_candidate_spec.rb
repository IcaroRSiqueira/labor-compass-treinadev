require 'rails_helper'

feature 'Headhunter send proposal to candidate' do
  scenario 'from home page' do
    headhunter = create(:headhunter)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva')
    create(:entry, candidate: candidate, vacancy: vacancy)

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Aplicaçōes recebidas'
    click_on 'Enviar proposta para candidato'
    fill_in 'Data prevista para início', with: 20.day.from_now
    fill_in 'Carga horária', with: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais'
    fill_in 'Benefícios', with: 'Vale transporte e alimentação'
    fill_in 'Salário', with: 'R$ 3000,00 ao mês'
    fill_in 'Detalhes', with: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa'
    click_on 'Enviar proposta'

    expect(page).to have_content("Proposta enviada!")
    expect(page).to have_link("Desenvolvedor")
    expect(page).to have_content("Leticia Silva")
    expect(page).to have_content("Status: Aguardando resposta")
  end
  scenario 'Must fill in all fields' do
    headhunter = create(:headhunter)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva')
    create(:entry, candidate: candidate, vacancy: vacancy)

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Aplicaçōes recebidas'
    click_on 'Enviar proposta para candidato'
    fill_in 'Data prevista para início', with: 20.day.from_now
    fill_in 'Carga horária', with: ''
    fill_in 'Benefícios', with: 'Vale transporte e alimentação'
    fill_in 'Salário', with: ''
    fill_in 'Detalhes', with: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa'
    click_on 'Enviar proposta'

    expect(page).not_to have_content("Proposta enviada!")
    expect(page).to have_content("Carga horária não pode ficar em branco")
    expect(page).to have_content("Salário não pode ficar em branco")
  end

  scenario 'cannot send another proposal to the same candidate about the same entry' do
    headhunter = create(:headhunter)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva')
    entry = create(:entry, candidate: candidate, vacancy: vacancy)
    create(:proposal, entry: entry, candidate: candidate, headhunter: headhunter)

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Aplicaçōes recebidas'
    click_on 'Enviar proposta para candidato'
    fill_in 'Data prevista para início', with: 30.day.from_now
    fill_in 'Carga horária', with: 'Segunda a sabado, das 9 as 17h'
    fill_in 'Benefícios', with: 'nenhum'
    fill_in 'Salário', with: 'R$ 1000,00 ao mês'
    fill_in 'Detalhes', with: 'Trabalho junto a equipe de desenvolvimento'
    click_on 'Enviar proposta'

    expect(page).not_to have_content("Proposta enviada!")
    expect(page).to have_content('Você ja enviou uma proposta para esta aplicação')
  end

  scenario 'headhunter must not see proposals of another headhunter' do
    headhunter = create(:headhunter, name: 'Teste Inc')
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    headhunter2 = create(:headhunter, name: 'Dummy', email: 'headhunter2@test.com')
    vacancy2 = create(:vacancy, headhunter: headhunter, title: 'Motorista')
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva')
    entry = create(:entry, candidate: candidate, vacancy: vacancy)
    create(:proposal, entry: entry, candidate: candidate, headhunter: headhunter)
    entry2 = create(:entry, candidate: candidate, vacancy: vacancy2)
    create(:proposal, entry: entry2, candidate: candidate, headhunter: headhunter2)

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Minhas propostas'

    expect(page).to have_content("Desenvolvedor")
    expect(page).to have_content("Leticia Silva")
    expect(page).to have_content("Status: Aguardando resposta")
    expect(page).not_to have_content("Motorista")
  end
end
