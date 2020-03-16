require 'rails_helper'

RSpec.describe Proposal, type: :model do
  describe 'Must fill in field' do
    it 'success' do

      headhunter = Headhunter.create!(email: 'test@h.com', password: '123456',
                                      name: 'Teste Enterprises')
      candidate = Candidate.create!(email: 'test1@c.com', password: '123456',
                                    status: :complete)
      profile = Profile.create!(full_name: 'Junior Silva', social_name: 'Nome',
                                birth_date: '13/12/1985', education: 'Teste',
                                description: 'description',
                                experience: 'experience', candidate: candidate)
      vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Test',
                                skill: 'Skill', wage: '3000', role: 'Junior',
                                end_date: 15.day.from_now, location: 'Location',
                                headhunter: headhunter)
      entry = Entry.create!(candidate: candidate, vacancy: vacancy,
                    description: 'description', status: :rejected)
      proposal = Proposal.create!(entry: entry, candidate: candidate,
                                  start_date: 20.day.from_now, wage: 'wage',
                                  workload: 'workload', benefits: 'Benefits',
                                  details: 'Detalhes', headhunter: headhunter)

      proposal.valid?

      expect(proposal.errors).to be_empty
    end

    it 'must fill all fields' do
      headhunter = Headhunter.create!(email: 'test@h.com', password: '123456',
                                      name: 'Teste Enterprises')
      candidate = Candidate.create!(email: 'test1@c.com', password: '123456',
                                    status: :complete)
      profile = Profile.create!(full_name: 'Junior Silva', social_name: 'Name',
                                birth_date: '13/12/1985', education: 'educacao',
                                description: 'Curso finalizado em 2010',
                                experience: 'experience', candidate: candidate)
      vacancy = Vacancy.create!(title: 'Title', description: 'Description',
                                skill: 'skill', wage: '3000', role: 'Junior',
                                end_date: 15.day.from_now, location: 'Location',
                                headhunter: headhunter)
      entry = Entry.create!(candidate: candidate, vacancy: vacancy,
                            description: 'Description', status: :rejected)
      proposal = Proposal.create(entry: entry, candidate: candidate,
                                  start_date: 20.day.from_now, workload: '',
                                  benefits: 'Vale transporte e alimentação',
                                  wage: 'wage', details: 'Details',
                                  headhunter: headhunter)

      error = 'Carga horária não pode ficar em branco'

      proposal.valid?

      expect(proposal.errors.full_messages).to include error
    end

    it 'must fill all fields' do
      headhunter = Headhunter.create!(email: 'test@h.com', password: '123456',
                                      name: 'Teste Enterprises')
      candidate = Candidate.create!(email: 'test1@c.com', password: '123456',
                                    status: :complete)
      profile = Profile.create!(full_name: 'Junior Silva', social_name: 'Name',
                                birth_date: '13/12/1985', education: 'educacao',
                                description: 'Curso finalizado em 2010',
                                experience: 'experience', candidate: candidate)
      vacancy = Vacancy.create!(title: 'Title', description: 'Description',
                                skill: 'skill', wage: '3000', role: 'Junior',
                                end_date: 15.day.from_now, location: 'Location',
                                headhunter: headhunter)
      entry = Entry.create!(candidate: candidate, vacancy: vacancy,
                            description: 'Description', status: :rejected)
      proposal = Proposal.create(entry: entry, candidate: candidate,
                                  start_date: '', workload: 'workload',
                                  benefits: '', wage: '', details: 'Details',
                                  headhunter: headhunter)

      start_date_error = 'Data prevista para início não pode ficar em branco'
      benefits_error = 'Benefícios não pode ficar em branco'
      wage_error = 'Salário não pode ficar em branco'

      proposal.valid?

      expect(proposal.errors.full_messages).to include start_date_error,
                                                        benefits_error,
                                                        wage_error
    end
  end
end
