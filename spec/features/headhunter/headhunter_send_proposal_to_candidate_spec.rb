require 'rails_helper'

feature 'Headhunter send proposal to candidate' do
  scenario 'from home page' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate1 = Candidate.create!(email: 'test1@test.com', password: '123456', status: :complete)
    profile1 = Profile.create!(full_name: 'Junior Silva', social_name: 'Leticia Silva',
                              birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                              description: 'Curso finalizado em 2010',
                              experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate1)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter)
    Entry.create!(candidate: candidate1, vacancy: vacancy,
                         description: 'Possuo bastante experiencia como desenvolvedor')

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
    expect(page).to have_link("Desenvolvedor Web")
    expect(page).to have_content("Leticia Silva")
  end
  scenario 'Must fill in all fields' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate1 = Candidate.create!(email: 'test1@test.com', password: '123456', status: :complete)
    profile1 = Profile.create!(full_name: 'Junior Silva', social_name: 'Leticia Silva',
                              birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                              description: 'Curso finalizado em 2010',
                              experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate1)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter)
    Entry.create!(candidate: candidate1, vacancy: vacancy,
                         description: 'Possuo bastante experiencia como desenvolvedor')

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

  scenario 'cannot_send_another_proposal_to_the_same_candidato_about_the_same_entry' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate1 = Candidate.create!(email: 'test1@test.com', password: '123456', status: :complete)
    profile1 = Profile.create!(full_name: 'Junior Silva', social_name: 'Leticia Silva',
                              birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                              description: 'Curso finalizado em 2010',
                              experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate1)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter)
    entry = Entry.create!(candidate: candidate1, vacancy: vacancy,
                         description: 'Possuo bastante experiencia como desenvolvedor')
    Proposal.create!(entry: entry, candidate: candidate1, start_date: 20.day.from_now,
                     workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                     benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                     details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa, favor, enviar telefone para contato no campo mensagem adicional', headhunter: headhunter)
    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Aplicaçōes recebidas'
    click_on 'Enviar proposta para candidato'
    fill_in 'Data prevista para início', with: 30.day.from_now
    fill_in 'Carga horária', with: 'Segunda a sabado, das 9 as 17h, totalizando 41 horas semanais'
    fill_in 'Benefícios', with: 'nenhum'
    fill_in 'Salário', with: 'R$ 1000,00 ao mês'
    fill_in 'Detalhes', with: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa'
    click_on 'Enviar proposta'

    expect(page).not_to have_content("Proposta enviada!")
    expect(page).to have_content('Você ja enviou uma proposta para esta aplicação')
  end

  scenario 'headhunter must not see proposals of another headhunter' do
    headhunter2 = Headhunter.create!(email: 'test@test2.com', password: '123456',
                                    name: 'Teste Enterprises')
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate = Candidate.create!(email: 'test@test.com', password: '123456', status: :complete)
    profile = Profile.create!(full_name: 'Joao Alberto', social_name: 'Maria de Lourdes',
                              birth_date: '20/05/1989', education: 'Ciencias da computação pela anhanguera',
                              description: 'Curso finalizado em 2010',
                              experience: 'Sem experiência', candidate: candidate)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable)
    entry = Entry.create!(candidate: candidate, vacancy: vacancy, status: :avaiable,
                          description: 'Não possuo nenhuma experiência na área')
    candidate2 = Candidate.create!(email: 'test2@test.com', password: '123456', status: :complete)
    profile2 = Profile.create!(full_name: 'Jose Silva', social_name: 'Jose Silva',
                              birth_date: '12/12/1990', education: 'Graduação em processos gerenciais pela anhanguera',
                              description: 'Curso finalizado em 2010',
                              experience: '5 anos de experiencia em gerencia de lanchonete', candidate: candidate2)
    vacancy2 = Vacancy.create!(title: 'Gerente de projetos', description: 'Gerenciar equipes em projetos',
                    skill: 'Experiencia com processos gerenciais', wage: '4500', role: 'Pleno',
                    end_date: 20.day.from_now, location: 'Av Rebouças', headhunter: headhunter2, status: :avaiable)
    entry2 = Entry.create!(candidate: candidate2, vacancy: vacancy2, status: :avaiable,
                          description: 'Possuo experiencia como gerente em lanchonete')
    proposal1 = Proposal.create!(entry: entry, candidate: candidate, start_date: 20.day.from_now,
                                 workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                                 benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                                 details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa', headhunter: headhunter)
    proposal2 = Proposal.create!(entry: entry2, candidate: candidate2, start_date: 15.day.from_now,
                                 workload: 'Segunda a quinta feira, das 7 as 18h',
                                 benefits: 'Vale alimentação', wage: 'R$ 4500,00 ao mês',
                                 details: 'A gerente devera gerenciar as equipes dos projetos', headhunter: headhunter2)

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Minhas propostas'

    expect(page).to have_content("Desenvolvedor Web")
    expect(page).to have_content("Maria de Lourdes")
    expect(page).not_to have_content("Gerente de projetos")
    expect(page).not_to have_content("Jose Silva")
  end
end
