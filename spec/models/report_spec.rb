require 'rails_helper'

RSpec.describe Report, type: :model do
  describe 'may fill field or not' do
    it 'success, refused' do

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
      entry = Entry.create!(candidate: candidate1, vacancy: vacancy,
                            description: 'Possuo bastante experiencia como desenvolvedor')
      proposal1 = Proposal.create!(entry: entry, candidate: candidate1, start_date: 20.day.from_now,
                                   workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                                   benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                                   details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa, favor, enviar telefone para contato no campo mensagem adicional',
                                   status: :refused)
      report = Report.create!(proposal: proposal1, body: 'Infelizmente a minha expecativa de salario esta acima da oferecida')

      report.valid?

      expect(report.errors).to be_empty
    end

    it 'dont fill, refused' do
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
      entry = Entry.create!(candidate: candidate1, vacancy: vacancy,
                            description: 'Possuo bastante experiencia como desenvolvedor')
      proposal1 = Proposal.create!(entry: entry, candidate: candidate1, start_date: 20.day.from_now,
                                   workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                                   benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                                   details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa, favor, enviar telefone para contato no campo mensagem adicional',
                                   status: :refused)
      report = Report.create!(proposal: proposal1, body: '')

      report.valid?

      expect(report.errors).to be_empty
    end
    it 'success, accepted' do

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
      entry = Entry.create!(candidate: candidate1, vacancy: vacancy,
                            description: 'Possuo bastante experiencia como desenvolvedor')
      proposal1 = Proposal.create!(entry: entry, candidate: candidate1, start_date: 20.day.from_now,
                                   workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                                   benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                                   details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa, favor, enviar telefone para contato no campo mensagem adicional',
                                   status: :accepted)
      report = Report.create!(proposal: proposal1, body: 'Obrigado pela oportunidade')

      report.valid?

      expect(report.errors).to be_empty
    end

    it 'dont fill, accepted' do
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
      entry = Entry.create!(candidate: candidate1, vacancy: vacancy,
                            description: 'Possuo bastante experiencia como desenvolvedor')
      proposal1 = Proposal.create!(entry: entry, candidate: candidate1, start_date: 20.day.from_now,
                                   workload: 'Segunda a sexta-feira, das 9 as 17h, totalizando 41 horas semanais',
                                   benefits: 'Vale transporte e alimentação', wage: 'R$ 3000,00 ao mês',
                                   details: 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa, favor, enviar telefone para contato no campo mensagem adicional',
                                   status: :accepted)
      report = Report.create!(proposal: proposal1, body: '')

      report.valid?

      expect(report.errors).to be_empty
    end
  end
end
