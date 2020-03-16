require 'rails_helper'

feature 'Headhunter register vacancy' do
  scenario 'from home page' do
    headhunter = create(:headhunter)

    login_as(headhunter, scope: :headhunter)
    visit root_path

    click_on 'Cadastrar nova vaga'

    fill_in 'Título', with: 'Caçador de candidatos'
    fill_in 'Descrição', with: 'O funcionário deverá pesquisar por perfis de
                                possíveis futuros funcionários'
    fill_in 'Habilidades necessárias', with: 'Bom relacionamento interpessoal'
    fill_in 'Salário', with: '2500-3000'
    fill_in 'Função', with: 'Pleno'
    fill_in 'Data de término', with: 10.day.from_now
    fill_in 'Localização', with: 'Av. Faria Lima'
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
    headhunter = create(:headhunter)

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Cadastrar nova vaga'

    fill_in 'Título', with: ''
    fill_in 'Descrição', with: 'O funcionário deverá pesquisar por perfis de
                                possíveis futuros funcionários'
    fill_in 'Habilidades necessárias', with: 'Bom relacionamento interpessoal'
    fill_in 'Salário', with: '2500-3000'
    fill_in 'Função', with: 'Pleno'
    fill_in 'Data de término', with: 10.day.from_now
    fill_in 'Localização', with: 'Av. Faria Lima'
    click_on 'Registrar vaga'

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'delete vacancy' do
    headhunter = create(:headhunter)

    create(:vacancy, headhunter: headhunter, title: 'Caçador de candidatos')

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Minhas vagas'
    click_on 'Caçador de candidatos'
    click_on 'Deletar vaga'

    expect(page).to have_content('Nenhuma vaga disponível no momento')
    expect(page).not_to have_link('Caçador de candidatos')
  end

  scenario 'must not see other headhunter vacancies' do
    headhunter = create(:headhunter)
    create(:vacancy, headhunter: headhunter, title: 'Caçador de candidatos', description: 'Finder de candidatos')
    headhunter2 = create(:headhunter, email: 'headhunter2@test.com', name: 'inc')
    create(:vacancy, headhunter: headhunter2, title: 'Headhunter Seeker', description: 'Procurador de headhunters')

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Minhas vagas'

    expect(page).to have_content('Caçador de candidatos')
    expect(page).to have_content('Finder de candidatos')
    expect(page).not_to have_content('Headhunter Seeker')
    expect(page).not_to have_content('Procurador de headhunters')
  end

  scenario 'cant delete vacancy when there are entries' do
    headhunter = create(:headhunter)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor Web')
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate, social_name: 'Leticia Silva')
    create(:entry, candidate: candidate, vacancy: vacancy, description: 'Não possuo experiência')

    login_as(headhunter, scope: :headhunter)

    visit root_path

    click_on 'Minhas vagas'
    click_on 'Desenvolvedor Web'
    click_on 'Deletar vaga'

    expect(page).to have_content('Não é possível deletar uma vaga que ja possui aplicações')
    expect(page).to have_link('Desenvolvedor Web')
  end
end
