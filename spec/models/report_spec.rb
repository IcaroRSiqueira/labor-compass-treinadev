require 'rails_helper'

RSpec.describe Report, type: :model do
  describe 'may fill field or not' do
    it 'success, refused' do

      headhunter = Headhunter.create!(email: 'test@h.com', password: '123456',
                                      name: 'Teste Enterprises')
      candidate1 = Candidate.create!(email: 'test1@c.com', password: '123456',
                                      status: :complete)
      profile1 = Profile.create!(full_name: 'Junior Silva', social_name: 'Name',
                                birth_date: '13/12/1985', education: 'None',
                                description: 'Curso finalizado em 2010',
                                experience: 'Nenhuma', candidate: candidate1)
      vacancy = Vacancy.create!(title: 'Desenvolvedor', description: 'Descr.',
                      skill: 'Experiences', wage: '3000', role: 'role',
                      end_date: 15.day.from_now, location: 'location',
                      headhunter: headhunter)
      entry = Entry.create!(candidate: candidate1, vacancy: vacancy,
                            description: 'Descrição')
      proposal1 = Proposal.create!(entry: entry, candidate: candidate1,
                                    start_date: 20.day.from_now,
                                    workload: 'Workload', benefits: 'benefits',
                                    wage: 'Salario', details: 'detalhes',
                                    status: :refused, headhunter: headhunter)
      report = Report.create!(proposal: proposal1, body: 'Resposta')

      report.valid?

      expect(report.errors).to be_empty
    end

    it 'dont fill, refused' do
      headhunter = Headhunter.create!(email: 'test@h.com', password: '123456',
                                      name: 'Teste Enterprises')
      candidate1 = Candidate.create!(email: 'test1@c.com', password: '123456',
                                      status: :complete)
      profile1 = Profile.create!(full_name: 'Junior Silva', social_name: 'Name',
                                birth_date: '13/12/1985', education: 'None',
                                description: 'Curso finalizado em 2010',
                                experience: 'Nenhuma', candidate: candidate1)
      vacancy = Vacancy.create!(title: 'Desenvolvedor', description: 'Descr.',
                      skill: 'Experiences', wage: '3000', role: 'role',
                      end_date: 15.day.from_now, location: 'location',
                      headhunter: headhunter)
      entry = Entry.create!(candidate: candidate1, vacancy: vacancy,
                            description: 'Descrição')
      proposal1 = Proposal.create!(entry: entry, candidate: candidate1,
                                    start_date: 20.day.from_now,
                                    workload: 'Workload', benefits: 'benefits',
                                    wage: 'Salario', details: 'detalhes',
                                    status: :refused, headhunter: headhunter)
      report = Report.create!(proposal: proposal1, body: '')

      report.valid?

      expect(report.errors).to be_empty
    end
    it 'success, accepted' do

      headhunter = Headhunter.create!(email: 'test@h.com', password: '123456',
                                      name: 'Teste Enterprises')
      candidate1 = Candidate.create!(email: 'test1@c.com', password: '123456',
                                      status: :complete)
      profile1 = Profile.create!(full_name: 'Junior Silva', social_name: 'Name',
                                birth_date: '13/12/1985', education: 'None',
                                description: 'Curso finalizado em 2010',
                                experience: 'Nenhuma', candidate: candidate1)
      vacancy = Vacancy.create!(title: 'Desenvolvedor', description: 'Descr.',
                      skill: 'Experiences', wage: '3000', role: 'role',
                      end_date: 15.day.from_now, location: 'location',
                      headhunter: headhunter)
      entry = Entry.create!(candidate: candidate1, vacancy: vacancy,
                            description: 'Descrição')
      proposal1 = Proposal.create!(entry: entry, candidate: candidate1,
                                    start_date: 20.day.from_now,
                                    workload: 'Workload', benefits: 'benefits',
                                    wage: 'Salario', details: 'detalhes',
                                    status: :accepted, headhunter: headhunter)
      report = Report.create!(proposal: proposal1, body: 'Obrigado')

      report.valid?

      expect(report.errors).to be_empty
    end

    it 'dont fill, accepted' do
      headhunter = Headhunter.create!(email: 'test@h.com', password: '123456',
                                      name: 'Teste Enterprises')
      candidate1 = Candidate.create!(email: 'test1@c.com', password: '123456',
                                      status: :complete)
      profile1 = Profile.create!(full_name: 'Junior Silva', social_name: 'Name',
                                birth_date: '13/12/1985', education: 'None',
                                description: 'Curso finalizado em 2010',
                                experience: 'Nenhuma', candidate: candidate1)
      vacancy = Vacancy.create!(title: 'Desenvolvedor', description: 'Descr.',
                      skill: 'Experiences', wage: '3000', role: 'role',
                      end_date: 15.day.from_now, location: 'location',
                      headhunter: headhunter)
      entry = Entry.create!(candidate: candidate1, vacancy: vacancy,
                            description: 'Descrição')
      proposal1 = Proposal.create!(entry: entry, candidate: candidate1,
                                    start_date: 20.day.from_now,
                                    workload: 'Workload', benefits: 'benefits',
                                    wage: 'Salario', details: 'detalhes',
                                    status: :accepted, headhunter: headhunter)
      report = Report.create!(proposal: proposal1, body: '')

      report.valid?

      expect(report.errors).to be_empty
    end
  end
end
