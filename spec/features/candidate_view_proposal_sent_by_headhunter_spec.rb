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
                     details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa')

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
end
