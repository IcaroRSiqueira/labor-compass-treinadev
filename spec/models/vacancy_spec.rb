require 'rails_helper'
require 'time_helpers'

RSpec.describe Vacancy, type: :model do
  describe '.end_date_must_be_greater_than_today' do
    it 'success' do
      headhunter = Headhunter.create(email: 'test@test.com', password: '123456',
                                      name: 'Teste Enterprises')
      vacancy = Vacancy.create(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                      skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                      end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter)


      vacancy.valid?

      expect(vacancy.errors).to be_empty
    end

    it 'end date less than start date' do
      headhunter = Headhunter.create(email: 'test@test.com', password: '123456',
                                      name: 'Teste Enterprises')
      vacancy = Vacancy.create(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                      skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                      end_date: 5.days.ago, location: 'Av Paulista', headhunter: headhunter)



      vacancy.valid?

      expect(vacancy.errors.full_messages).to include 'End date deve ser maior que data de fim'
    end

    it 'end date less than start date' do
      headhunter = Headhunter.create(email: 'test@test.com', password: '123456',
                                      name: 'Teste Enterprises')
      vacancy = Vacancy.create(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                      skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                      end_date: 1.days.ago, location: 'Av Paulista', headhunter: headhunter)



      vacancy.valid?

      expect(vacancy.errors.full_messages).to include 'End date deve ser maior que data de fim'
    end

    it 'end date less than start date' do
      headhunter = Headhunter.create(email: 'test@test.com', password: '123456',
                                      name: 'Teste Enterprises')
      vacancy = Vacancy.create(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                      skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                      end_date: Date.current , location: 'Av Paulista', headhunter: headhunter)



      vacancy.valid?

      expect(vacancy.errors.full_messages).to include 'End date deve ser maior que data de fim'
    end

  xdescribe '.vacancy_expiration' do
    it 'success' do
      headhunter = Headhunter.create(email: 'test@test.com', password: '123456',
                                     name: 'Teste Enterprises')
      vacancy = Vacancy.create(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                               skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                               end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable)


        travel_to 16.days.from_now
        Delayed::Worker.new.work_off
        vacancy.reload
        expect(vacancy).to have_attributes(status: 'finalized')
      end
    end
  end
end
