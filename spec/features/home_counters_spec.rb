require 'rails_helper'


feature 'Index counter' do
  scenario '1 headhunter' do
    create(:headhunter)

    visit root_path

    expect(page).to have_content("1 empresa(s) cadastrada(s)")
  end

  scenario '0 headhunter' do

    visit root_path

    expect(page).to have_content("0 empresa(s) cadastrada(s)")
  end

  scenario '3 headhunter' do
    create_list(:headhunter, 3)
    visit root_path

    expect(page).to have_content("3 empresa(s) cadastrada(s)")
  end

  scenario '100 headhunter' do
    create_list(:headhunter, 100)
    visit root_path

    expect(page).to have_content("100 empresa(s) cadastrada(s)")
  end

  scenario '1 candidate' do
    create(:candidate)

    visit root_path

    expect(page).to have_content("1 candidato(s) cadastrado(s)")
  end

  scenario '0 candidate' do
    visit root_path

    expect(page).to have_content("0 candidato(s) cadastrado(s)")
  end

  scenario '3 candidate' do
    create_list(:candidate, 3)

    visit root_path

    expect(page).to have_content("3 candidato(s) cadastrado(s)")
  end

  scenario '100 candidate' do
    create_list(:candidate, 100)

    visit root_path

    expect(page).to have_content("100 candidato(s) cadastrado(s)")
  end

  scenario '1 vacancy' do
    create(:vacancy)

    visit root_path

    expect(page).to have_content("1 vaga(s) disponível(is)")
  end

  scenario '0 vacancy' do
    visit root_path

    expect(page).to have_content("0 vaga(s) disponível(is)")
  end

  scenario '3 vacancy' do
    create_list(:vacancy, 3)

    visit root_path

    expect(page).to have_content("3 vaga(s) disponível(is)")
  end

  scenario 'vacancy entry average 0' do
    create(:vacancy)

    visit root_path

    expect(page).to have_content("Em média, cada vaga cadastrada recebe 0 \
aplicaçōes")
  end

  scenario 'vacancy entry average 2' do
    candidate = create(:candidate)
    candidate2 = create(:candidate)

    vacancy = create(:vacancy)
    create(:entry, candidate: candidate, vacancy: vacancy)
    create(:entry, candidate: candidate2, vacancy: vacancy)
    vacancy2 = create(:vacancy)
    create(:entry, candidate: candidate, vacancy: vacancy2)
    create(:entry, candidate: candidate2, vacancy: vacancy2)

    visit root_path

    expect(page).to have_content("Em média, cada vaga cadastrada recebe 2 \
aplicaçōes")
  end

  scenario 'vacancy entry average 2/5 == 2' do
    candidate = create(:candidate)
    candidate2 = create(:candidate)
    candidate3 = create(:candidate)

    vacancy = create(:vacancy)
    create(:entry, candidate: candidate, vacancy: vacancy)
    create(:entry, candidate: candidate2, vacancy: vacancy)

    vacancy2 = create(:vacancy)
    create(:entry, candidate: candidate, vacancy: vacancy2)
    create(:entry, candidate: candidate2, vacancy: vacancy2)
    create(:entry, candidate: candidate3, vacancy: vacancy2)

    visit root_path

    expect(page).to have_content("Em média, cada vaga cadastrada recebe 2 \
aplicaçōes")
  end

  scenario 'vacancy entry average 0' do

    visit root_path

    expect(page).to have_content("Em média, cada vaga cadastrada recebe 0 \
aplicaçōes")
  end

  scenario 'average proposal to entry 0' do

    visit root_path

    expect(page).to have_content("Em média, 0% das aplicaçōes recebem \
propostas!")
  end

  scenario 'average proposal to entry 50' do
    entry = create(:entry)
    entry2 = create(:entry)
    entry3 = create(:entry)
    entry4 = create(:entry)


    create(:proposal, entry: entry)
    create(:proposal, entry: entry2)

    visit root_path

    expect(page).to have_content("Em média, 50% das aplicaçōes recebem \
propostas!")
  end

  scenario 'average proposal to entry 33.3' do
    entry = create(:entry)
    entry2 = create(:entry)
    entry3 = create(:entry)

    create(:proposal, entry: entry)

    visit root_path

    expect(page).to have_content("Em média, 33% das aplicaçōes recebem \
propostas!")
  end
end
