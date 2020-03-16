require 'rails_helper'

RSpec.describe Entry, type: :model do
  describe 'Must fill in field' do
    it 'success' do
      headhunter = Headhunter.create!(email: 'test@h.com', password: '123456',
                                      name: 'Teste Enterprises')
      candidate = Candidate.create!(email: 'test1@c.com', password: '123456',
                                    status: :complete)
      profile = Profile.create!(full_name: 'Name', social_name: 'Name',
                                birth_date: '13/12/1985', education: 'School',
                                description: 'description', experience: 'xp',
                                candidate: candidate)
      vacancy = Vacancy.create!(title: 'Title', description: 'Description',
                                skill: 'Skill', wage: '3000', role: 'Role',
                                end_date: 15.day.from_now, location: 'Location',
                                headhunter: headhunter)
      entry = Entry.create!(candidate: candidate, vacancy: vacancy,
                            description: 'Description')


      entry.valid?

      expect(entry.errors).to be_empty
    end
    it 'Description cant be blank' do
      headhunter = Headhunter.create(email: 'test@h.com', password: '123456',
                                      name: 'Teste Enterprises')
      candidate = Candidate.create(email: 'test1@c.com', password: '123456',
                                    status: :complete)
      profile = Profile.create(full_name: 'Name', social_name: 'Name',
                                birth_date: '13/12/1985', education: 'School',
                                description: 'description', experience: 'xp',
                                candidate: candidate)
      vacancy = Vacancy.create(title: 'Title', description: 'Description',
                                skill: 'Skill', wage: '3000', role: 'Role',
                                end_date: 15.day.from_now, location: 'Location',
                                headhunter: headhunter)
      entry = Entry.create(candidate: candidate, vacancy: vacancy,
                            description: '')

      error = 'Sua descrição não pode ficar em branco'

      entry.valid?

      expect(entry.errors.full_messages).to include error
    end
  end
end
