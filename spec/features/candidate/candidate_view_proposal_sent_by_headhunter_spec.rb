require 'rails_helper'

feature 'Candidate view proposal' do
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

    expect(page).to have_content("Teste Enterprises")
    expect(page).to have_content("Leticia Silva")
    expect(page).to have_content(20.day.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content("Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais")
    expect(page).to have_content("Vale transporte e alimentação")
    expect(page).to have_content("R$ 3000,00 ao mês")
    expect(page).to have_content("A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa")
  end

  scenario 'candidate must not see proposals of another candidate' do
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
                    end_date: 20.day.from_now, location: 'Av Rebouças', headhunter: headhunter, status: :avaiable)
    entry2 = Entry.create!(candidate: candidate2, vacancy: vacancy2, status: :avaiable,
                          description: 'Possuo experiencia como gerente em lanchonete')
    Proposal.create!(entry: entry, candidate: candidate, start_date: 20.day.from_now,
                     workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                     benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                     details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa', headhunter: headhunter)

    Proposal.create!(entry: entry2, candidate: candidate2, start_date: 15.day.from_now,
                     workload: 'Segunda a quinta feira, das 7 as 18h',
                     benefits: 'Vale alimentação', wage: 'R$ 4500,00 ao mês',
                     details: 'A gerente devera gerenciar as equipes dos projetos', headhunter: headhunter)

    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Propostas recebidas'

    expect(page).to have_content("Desenvolvedor Web")
    expect(page).to have_content("Maria de Lourdes")
    expect(page).not_to have_content("Gerente de projetos")
    expect(page).not_to have_content("Jose Silva")
  end
end
