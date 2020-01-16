require 'rails_helper'

RSpec.describe Proposal, type: :model do
  describe 'Must fill in field' do
    it 'success' do

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
      proposal = Proposal.create!(entry: entry, candidate: candidate, start_date: 20.day.from_now,
                       workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                       benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                       details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa', headhunter: headhunter)

      proposal.valid?

      expect(proposal.errors).to be_empty
    end

    it 'must fill all fields' do
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
      proposal = Proposal.create(entry: entry, candidate: candidate, start_date: 20.day.from_now,
                       workload: '',
                       benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                       details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa', headhunter: headhunter)


      proposal.valid?

      expect(proposal.errors.full_messages).to include 'Workload não pode ficar em branco'
    end

    it 'must fill all fields' do
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
      proposal = Proposal.create(entry: entry, candidate: candidate, start_date: '',
                       workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                       benefits: '', wage: '',
                       details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa', headhunter: headhunter)


      proposal.valid?

      expect(proposal.errors.full_messages).to include "Start date não pode ficar em branco",
                                                      "Benefits não pode ficar em branco",
                                                      "Wage não pode ficar em branco"
    end
  end
end
