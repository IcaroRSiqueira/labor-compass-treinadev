require 'rails_helper'

feature 'Candidate accept proposal' do
  scenario 'from home page' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate = Candidate.create!(email: 'test1@test.com', password: '123456', status: :complete)
    profile = Profile.create!(full_name: 'Junior Silva', social_name: 'Leticia Silva',
                              birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                              description: 'Curso finalizado em 2010',
                              experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter)
    vacancy2 = Vacancy.create!(title: 'Corretor de seguro', description: 'Analise e calculo base de valores de seguro',
                              skill: 'Experiencia com calculos de seguro', wage: '2000', role: 'Pleno',
                              end_date: 20.day.from_now, location: 'Av Rebouças', headhunter: headhunter)
    entry = Entry.create!(candidate: candidate, vacancy: vacancy,
                          description: 'Possuo bastante experiencia como desenvolvedor')
    entry2 = Entry.create!(candidate: candidate, vacancy: vacancy2,
                           description: 'Possuo pouca experiencia com ciencias atuariais')
    Proposal.create!(entry: entry, candidate: candidate, start_date: 20.day.from_now,
                     workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                     benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                     details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa, favor, enviar telefone para contato no campo mensagem adicional', headhunter: headhunter)
    Proposal.create!(entry: entry2, candidate: candidate, start_date: 30.day.from_now,
                     workload: 'Segunda a sexta-feira, das 8 as 16h, totalizando 41 horas semanais',
                     benefits: 'Vale transporte e convenio medico', wage: 'R$ 2000,00 ao mês',
                     details: 'O analista deverá realizar os calculos e aplicaçōes de seguros, com possibilidade de trabalho Home Office', headhunter: headhunter)
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
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate = Candidate.create!(email: 'test1@test.com', password: '123456', status: :complete)
    profile = Profile.create!(full_name: 'Junior Silva', social_name: 'Leticia Silva',
                              birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                              description: 'Curso finalizado em 2010',
                              experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter)
    entry = Entry.create!(candidate: candidate, vacancy: vacancy,
                  description: 'Possuo bastante experiencia como desenvolvedor', status: :rejected)
    Proposal.create!(entry: entry, candidate: candidate, start_date: 20.day.from_now,
                     workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                     benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                     details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa', headhunter: headhunter)

    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Propostas recebidas'
    click_on vacancy.title
    click_on 'Rejeitar proposta'
    fill_in 'Mensagem adicional (opcional)', with: 'Infelizmente o salario nao é compativel com minha expectativa'
    click_on 'Confirmar rejeição da proposta'

    expect(page).to have_content("Proposta rejeitada com sucesso")
    expect(page).not_to have_content("Status: Proposta aceita")
    expect(page).to have_content("Status: Proposta recusada")
    expect(page).to have_content("Infelizmente o salario nao é compativel com minha expectativa")
    expect(page).not_to have_content("Status: Aguardando resposta")
  end

  scenario 'candidate returns to proposals index' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate = Candidate.create!(email: 'test1@test.com', password: '123456', status: :complete)
    profile = Profile.create!(full_name: 'Junior Silva', social_name: 'Leticia Silva',
                              birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                              description: 'Curso finalizado em 2010',
                              experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter)
    entry = Entry.create!(candidate: candidate, vacancy: vacancy,
                  description: 'Possuo bastante experiencia como desenvolvedor', status: :rejected)
    Proposal.create!(entry: entry, candidate: candidate, start_date: 20.day.from_now,
                     workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                     benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                     details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa', headhunter: headhunter)

    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Propostas recebidas'
    click_on vacancy.title
    click_on 'Voltar'

    expect(current_path).to eq entry_proposals_path(candidate)
  end
end
