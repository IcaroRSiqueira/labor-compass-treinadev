require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'Must fill in field' do
    it 'success' do

      candidate = Candidate.create!(email: 'test1@test.com', password: '123456',
                                    status: :complete)
      profile = Profile.create!(full_name: 'Name', social_name: 'Name',
                                birth_date: '13/12/1985', education: 'School',
                                description: 'description', experience: 'exp',
                                candidate: candidate)

      profile.valid?

      expect(profile.errors).to be_empty
    end

    it 'must fill all fields' do
      candidate = Candidate.create!(email: 'test1@test.com', password: '123456',
                                    status: :complete)
      profile = Profile.create(full_name: '', social_name: 'Leticia Silva',
                                birth_date: '13/12/1985', education: 'school',
                                description: 'Curso finalizado em 2010',
                                experience: 'experience', candidate: candidate)

      error = 'Nome completo não pode ficar em branco'

      profile.valid?

      expect(profile.errors.full_messages).to include error
    end

    it 'must fill all fields' do
      candidate = Candidate.create!(email: 'test1@test.com', password: '123456',
                                    status: :complete)
      profile = Profile.create(full_name: '', social_name: '',
                                birth_date: '13/12/1985', education: 'school',
                                description: '',
                                experience: 'experience', candidate: candidate)
      full_name_error = 'Nome completo não pode ficar em branco'
      social_name_error = 'Nome social não pode ficar em branco'
      description_error = 'Descrição não pode ficar em branco'

      profile.valid?

      expect(profile.errors.full_messages).to include full_name_error,
                                                      social_name_error,
                                                      description_error
    end
  end
end
