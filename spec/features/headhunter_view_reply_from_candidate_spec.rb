require 'rails_helper'

feature 'Candidate accept proposal' do
  scenario 'from home page' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    candidate1 = Candidate.create!(email: 'test1@test.com', password: '123456', status: :complete)
    candidate2 = Candidate.create!(email: 'test2@test.com', password: '123456', status: :complete)
    profile1 = Profile.create!(full_name: 'Junior Silva', social_name: 'Leticia Silva',
                              birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                              description: 'Curso finalizado em 2010',
                              experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate1)
    profile2 = Profile.create!(full_name: 'Jose Silva', social_name: 'Jose Silva',
                              birth_date: '12/12/1990', education: 'Graduação em ADS pela FMU',
                              description: 'Curso finalizado em 2015',
                              experience: '3 anos de desenvolvimento back end em ruby', candidate: candidate2)
    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter)
    vacancy2 = Vacancy.create!(title: 'Corretor de seguro', description: 'Analise e calculo base de valores de seguro',
                              skill: 'Experiencia com calculos de seguro', wage: '2000', role: 'Pleno',
                              end_date: 20.day.from_now, location: 'Av Rebouças', headhunter: headhunter)
    entry = Entry.create!(candidate: candidate1, vacancy: vacancy,
                          description: 'Possuo bastante experiencia como desenvolvedor')
    entry2 = Entry.create!(candidate: candidate2, vacancy: vacancy2,
                           description: 'Possuo pouca experiencia com ciencias atuariais')
    proposal1 = Proposal.create!(entry: entry, candidate: candidate1, start_date: 20.day.from_now,
                                 workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                                 benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                                 details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa, favor, enviar telefone para contato no campo mensagem adicional',
                                 status: :refused)
    proposal2= Proposal.create!(entry: entry2, candidate: candidate2, start_date: 30.day.from_now,
                                workload: 'Segunda a sexta-feira, das 8 as 16h, totalizando 41 horas semanais',
                                benefits: 'Vale transporte e convenio medico', wage: 'R$ 2000,00 ao mês',
                                details: 'O analista deverá realizar os calculos e aplicaçōes de seguros, com possibilidade de trabalho Home Office',
                                status: :accepted)
    Report.create!(proposal: proposal1, body: 'Infelizmente a minha expecativa de salario esta acima da oferecida')
    Report.create!(proposal: proposal2, body: 'Telefone para contato: (00) 0-0000-0000)')


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
