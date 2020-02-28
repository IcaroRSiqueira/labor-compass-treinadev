require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'Must fill in field' do
    it 'success' do

      candidate = Candidate.create!(email: 'test1@test.com', password: '123456', status: :complete)
      profile = Profile.create!(full_name: 'Junior Silva', social_name: 'Leticia Silva',
                                birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                                description: 'Curso finalizado em 2010',
                                experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate)

      profile.valid?

      expect(profile.errors).to be_empty
    end

    it 'must fill all fields' do
      candidate = Candidate.create!(email: 'test1@test.com', password: '123456', status: :complete)
      profile = Profile.create(full_name: '', social_name: 'Leticia Silva',
                                birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                                description: 'Curso finalizado em 2010',
                                experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate)


      profile.valid?

      expect(profile.errors.full_messages).to include 'Nome completo não pode ficar em branco'
    end

    it 'must fill all fields' do
      candidate = Candidate.create!(email: 'test1@test.com', password: '123456', status: :complete)
      profile = Profile.create(full_name: '', social_name: '',
                                birth_date: '13/12/1985', education: 'Graduação em ADS pela USP',
                                description: '',
                                experience: '5 anos de desenvolvimento front end em ruby e java', candidate: candidate)


      profile.valid?

      expect(profile.errors.full_messages).to include "Nome completo não pode ficar em branco",
                                                      "Nome social não pode ficar em branco",
                                                      "Descrição não pode ficar em branco"
    end
  end
end
