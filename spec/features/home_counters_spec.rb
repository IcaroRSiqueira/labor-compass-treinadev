require 'rails_helper'


feature 'Index counter' do
  scenario '1 headhunter' do
    Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')

    visit root_path

    expect(page).to have_content("1 empresa(s) cadastrada(s)")
  end

  scenario '0 headhunter' do

    visit root_path

    expect(page).to have_content("0 empresa(s) cadastrada(s)")
  end

  scenario '3 headhunter' do
    Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    Headhunter.create!(email: 'test2@test.com', password: '123456',
                                    name: 'Teste Enterprises2')
    Headhunter.create!(email: 'test3@test.com', password: '123456',
                                    name: 'Teste Enterprises3')
    visit root_path

    expect(page).to have_content("3 empresa(s) cadastrada(s)")
  end

  scenario '1 candidate' do
    Candidate.create!(email: 'test@test.com', password: '123456')

    visit root_path

    expect(page).to have_content("1 candidato(s) cadastrado(s)")
  end

  scenario '0 candidate' do
    visit root_path

    expect(page).to have_content("0 candidato(s) cadastrado(s)")
  end

  scenario '3 candidate' do
    Candidate.create!(email: 'test1@test.com', password: '123456')
    Candidate.create!(email: 'test2@test.com', password: '123456')
    Candidate.create!(email: 'test3@test.com', password: '123456')

    visit root_path

    expect(page).to have_content("3 candidato(s) cadastrado(s)")
  end

  scenario '1 vacancy' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable)

    visit root_path

    expect(page).to have_content("1 vaga(s) disponível(is)")
  end

  scenario '0 vacancy' do
    visit root_path

    expect(page).to have_content("0 vaga(s) disponível(is)")
  end

  scenario '3 vacancy' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable)
    Vacancy.create!(title: 'Desenvolvedor Web2', description: 'Desenvilvimento de paginas web com ruby on rails2',
                    skill: 'Experiencia com ruby on rails2', wage: '23000', role: 'Junior2',
                    end_date: 15.day.from_now, location: 'Av Paulista2', headhunter: headhunter, status: :avaiable)
    Vacancy.create!(title: 'Desenvolvedor Web3', description: 'Desenvilvimento de paginas web com ruby on rails3',
                    skill: 'Experiencia com ruby on rails3', wage: '33000', role: 'Junior3',
                    end_date: 15.day.from_now, location: 'Av Paulista3', headhunter: headhunter, status: :avaiable)

    visit root_path

    expect(page).to have_content("3 vaga(s) disponível(is)")
  end

  scenario 'vacancy entry average 0' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')
    Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable)

    visit root_path

    expect(page).to have_content("Em média, cada vaga cadastrada recebe 0 aplicaçōes")
  end

  scenario 'vacancy entry average 2' do
    candidate = Candidate.create!(email: 'test@test.com', password: '123456')
    candidate2 = Candidate.create!(email: 'test2@test.com', password: '123456')
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')

    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable)
    Entry.create!(candidate: candidate, vacancy: vacancy,
                  description: 'Possuo bastante experiencia como desenvolvedor2')
    Entry.create!(candidate: candidate2, vacancy: vacancy,
                  description: 'Possuo bastante experiencia como desenvolvedor1')
    vacancy2 = Vacancy.create!(title: 'Desenvolvedor Web2', description: 'Desenvilvimento de paginas web com ruby on rails2',
                skill: 'Experiencia com ruby on rails2', wage: '23000', role: 'Junior2',
                end_date: 15.day.from_now, location: 'Av Paulista2', headhunter: headhunter, status: :avaiable)
    Entry.create!(candidate: candidate, vacancy: vacancy2,
                  description: 'Possuo bastante experiencia como desenvolvedor2')
    Entry.create!(candidate: candidate2, vacancy: vacancy2,
                  description: 'Possuo bastante experiencia como desenvolvedor1')

    visit root_path

    expect(page).to have_content("Em média, cada vaga cadastrada recebe 2 aplicaçōes")
  end

  scenario 'vacancy entry average 2/5 == 2' do
    candidate = Candidate.create!(email: 'test@test.com', password: '123456')
    candidate2 = Candidate.create!(email: 'test2@test.com', password: '123456')
    candidate3 = Candidate.create!(email: 'test3@test.com', password: '123456')
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')

    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable)
    Entry.create!(candidate: candidate, vacancy: vacancy,
                  description: 'Possuo bastante experiencia como desenvolvedor2')
    Entry.create!(candidate: candidate2, vacancy: vacancy,
                  description: 'Possuo bastante experiencia como desenvolvedor1')
    vacancy2 = Vacancy.create!(title: 'Desenvolvedor Web2', description: 'Desenvilvimento de paginas web com ruby on rails2',
                skill: 'Experiencia com ruby on rails2', wage: '23000', role: 'Junior2',
                end_date: 15.day.from_now, location: 'Av Paulista2', headhunter: headhunter, status: :avaiable)
    Entry.create!(candidate: candidate, vacancy: vacancy2,
                  description: 'Possuo bastante experiencia como desenvolvedor2')
    Entry.create!(candidate: candidate2, vacancy: vacancy2,
                  description: 'Possuo bastante experiencia como desenvolvedor1')
    Entry.create!(candidate: candidate3, vacancy: vacancy2,
                  description: 'Possuo bastante experiencia como desenvolvedor3')
    visit root_path

    expect(page).to have_content("Em média, cada vaga cadastrada recebe 2 aplicaçōes")
  end

  scenario 'vacancy entry average 0' do

    visit root_path

    expect(page).to have_content("Em média, cada vaga cadastrada recebe 0 aplicaçōes")
  end

  scenario 'average proposal to entry 0' do

    visit root_path

    expect(page).to have_content("Em média, 0% das aplicaçōes recebem propostas!")
  end

  scenario 'average proposal to entry 50' do
    candidate = Candidate.create!(email: 'test@test.com', password: '123456')
    candidate2 = Candidate.create!(email: 'test2@test.com', password: '123456')
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')

    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable)
    entry1 = Entry.create!(candidate: candidate, vacancy: vacancy,
                  description: 'Possuo bastante experiencia como desenvolvedor2')
    entry2 = Entry.create!(candidate: candidate2, vacancy: vacancy,
                  description: 'Possuo bastante experiencia como desenvolvedor1')
    vacancy2 = Vacancy.create!(title: 'Desenvolvedor Web2', description: 'Desenvilvimento de paginas web com ruby on rails2',
                skill: 'Experiencia com ruby on rails2', wage: '23000', role: 'Junior2',
                end_date: 15.day.from_now, location: 'Av Paulista2', headhunter: headhunter, status: :avaiable)
    entry3 = Entry.create!(candidate: candidate, vacancy: vacancy2,
                  description: 'Possuo bastante experiencia como desenvolvedor2')
    entry4 = Entry.create!(candidate: candidate2, vacancy: vacancy2,
                  description: 'Possuo bastante experiencia como desenvolvedor1')

    Proposal.create!(entry: entry1, candidate: candidate, start_date: 20.day.from_now,
                     workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                     benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                     details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento')
    Proposal.create!(entry: entry2, candidate: candidate2, start_date: 20.day.from_now,
                     workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                     benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                     details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento')

    visit root_path

    expect(page).to have_content("Em média, 50% das aplicaçōes recebem propostas!")
  end

  scenario 'average proposal to entry 33.3' do
    candidate = Candidate.create!(email: 'test@test.com', password: '123456')
    candidate2 = Candidate.create!(email: 'test2@test.com', password: '123456')
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')

    vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                    skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                    end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable)
    entry1 = Entry.create!(candidate: candidate, vacancy: vacancy,
                  description: 'Possuo bastante experiencia como desenvolvedor2')
    entry2 = Entry.create!(candidate: candidate2, vacancy: vacancy,
                  description: 'Possuo bastante experiencia como desenvolvedor1')
    vacancy2 = Vacancy.create!(title: 'Desenvolvedor Web2', description: 'Desenvilvimento de paginas web com ruby on rails2',
                skill: 'Experiencia com ruby on rails2', wage: '23000', role: 'Junior2',
                end_date: 15.day.from_now, location: 'Av Paulista2', headhunter: headhunter, status: :avaiable)
    entry3 = Entry.create!(candidate: candidate, vacancy: vacancy2,
                  description: 'Possuo bastante experiencia como desenvolvedor2')

    Proposal.create!(entry: entry1, candidate: candidate, start_date: 20.day.from_now,
                     workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                     benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                     details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento')

    visit root_path

    expect(page).to have_content("Em média, 33% das aplicaçōes recebem propostas!")
  end
end
