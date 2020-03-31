require 'rails_helper'

feature 'Candidate register on vacancy' do
  scenario 'from home page' do
    headhunter = create(:headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor',
                                description: 'Desenvilvimento web',
                                skill: 'Experiencia com ruby on rails',
                                wage: '3000',
                                role: 'Junior', end_date: 15.day.from_now,
                                location: 'Av Paulista')
    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Vagas disponíveis'
    click_on vacancy.title
    fill_in 'Conte-nos mais sobre você!', with: "Possuo 3 anos de experiência \
em desenvolvimento web com ruby"
    click_on 'Aplicar-se à vaga'

    expect(page).to have_content("Cadastro realizado com sucesso!")
    expect(page).to have_content("Minhas vagas")
    expect(page).to have_content("Desenvolvedor")
    expect(page).to have_content("Desenvilvimento web")
    expect(page).to have_content("Experiencia com ruby on rails")
    expect(page).to have_content("3000")
    expect(page).to have_content("Junior")
    expect(page).to have_content(15.day.from_now.strftime('%d/%m/%Y'))
    expect(page).to have_content("Av Paulista")
  end

  scenario 'candidate cant register that was already applied by him' do
    headhunter = create(:headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate)
    vacancy = create(:vacancy, headhunter: headhunter)
    entry = create(:entry, candidate: candidate, vacancy: vacancy)
    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Vagas disponíveis'
    click_on vacancy.title
    fill_in 'Conte-nos mais sobre você!', with: "Possuo 3 anos de experiência \
em desenvolvimento web com ruby"
    click_on 'Aplicar-se à vaga'

    expect(page).not_to have_content("Cadastro realizado com sucesso!")
    expect(page).to have_content('Você ja se cadastrou para esta vaga')
  end

  scenario 'candidate must not see others candidate entry' do
    headhunter = create(:headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    create(:entry, candidate: candidate, vacancy: vacancy, status: :avaiable)
    candidate2 = create(:candidate, status: :complete, email: 'test@123')
    create(:profile, candidate: candidate2)
    vacancy2 = create(:vacancy, headhunter: headhunter,
                                title: 'Gerente de projetos')
    create(:entry, candidate: candidate2, vacancy: vacancy2, status: :avaiable)
    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Minhas vagas'

    expect(page).to have_content("Desenvolvedor")
    expect(page).not_to have_content("Gerente de projetos")
  end

  scenario 'must fill in all fields' do
    headhunter = create(:headhunter)
    candidate = create(:candidate, status: :complete)
    create(:profile, candidate: candidate)
    vacancy = create(:vacancy, headhunter: headhunter, title: 'Desenvolvedor')
    login_as(candidate, scope: :candidate)

    visit root_path

    click_on 'Vagas disponíveis'
    click_on 'Desenvolvedor'
    fill_in 'Conte-nos mais sobre você!', with: ''
    click_on 'Aplicar-se à vaga'

    expect(page).to have_content('Sua descrição não pode ficar em branco')
    expect(page).to have_content('Conte-nos mais sobre você!')
  end
end
