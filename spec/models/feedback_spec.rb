require 'rails_helper'

RSpec.describe Feedback, type: :model do
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
      feedback = Feedback.create!(entry: entry, body: 'Infelizmente o perfil não supriu as necessidades da vaga')


      feedback.valid?

      expect(feedback.errors).to be_empty
    end

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
      feedback = Feedback.create(entry: entry, body: '')

      feedback.valid?

      expect(feedback.errors.full_messages).to include 'Texto do feedback não pode ficar em branco'
    end
  end
end
