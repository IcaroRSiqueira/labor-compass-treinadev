require 'rails_helper'

feature 'Headhunter register vacancy' do
  scenario 'from home page' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste Enterprises')

    login_as(headhunter, scope: :headhunter)
    visit root_path

    click_on 'Cadastrar nova vaga'

    fill_in 'Título', with: 'Caçador de candidatos'
    fill_in 'Descrição', with: 'O funcionário deverá pesquisar por perfis de
                                possíveis futuros funcionários'
    fill_in 'Habilidades necessárias', with: 'Bom relacionamento interpessoal'
    fill_in 'Faixa salarial', with: '2500-3000'
    fill_in 'Nível do cargo', with: 'Pleno'
    fill_in 'Data limite de inscriçōes', with: 10.day.from_now
    fill_in 'Região', with: 'Av. Faria Lima'
    click_on 'Registrar vaga'


    expect(page).to have_content("Vaga cadastrada com sucesso")
    expect(page).to have_content("Caçador de candidatos")
    expect(page).to have_content("O funcionário deverá pesquisar por perfis de possíveis futuros funcionários")
    expect(page).to have_content("Bom relacionamento interpessoal")
    expect(page).to have_content("2500-3000")
    expect(page).to have_content("Pleno")
    expect(page).to have_content(10.day.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content("Av. Faria Lima")
  end

  scenario 'Must fill in all fields' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste.inc')

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Cadastrar nova vaga'

    fill_in 'Título', with: ''
    fill_in 'Descrição', with: 'O funcionário deverá pesquisar por perfis de
                                possíveis futuros funcionários'
    fill_in 'Habilidades necessárias', with: 'Bom relacionamento interpessoal'
    fill_in 'Faixa salarial', with: '2500-3000'
    fill_in 'Nível do cargo', with: 'Pleno'
    fill_in 'Data limite de inscriçōes', with: 10.day.from_now
    fill_in 'Região', with: 'Av. Faria Lima'
    click_on 'Registrar vaga'


    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'delete vacancy' do
    headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                    name: 'Teste.inc')
    Vacancy.create!(title: 'Caçador de candidatos', description: 'O funcionário
                    deverá pesquisar por perfis de possíveis futuros funcionários',
                    skill: 'Bom relacionamento interpessoal', wage: '2500-3000',
                    role: 'Pleno', end_date: 10.day.from_now, location: 'Av. Faria Lima', headhunter: headhunter)

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Minhas vagas'
    click_on 'Caçador de candidatos'
    click_on 'Deletar vaga'

    expect(page).to have_content('Nenhuma vaga disponível no momento')
    expect(page).not_to have_link('Caçador de candidatos')

  end
end
