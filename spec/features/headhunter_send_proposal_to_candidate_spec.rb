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
end
