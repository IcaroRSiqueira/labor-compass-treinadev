require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Must fill in field' do
    it 'success' do
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
                            description: 'Description')

      comment = Comment.create(entry: entry, body: 'Comentario teste')

      comment.valid?

      expect(vacancy.errors).to be_empty
    end

    it 'success' do
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
                            description: 'Description')

      comment = Comment.create(entry: entry, body: '')
      error = 'Texto do comentário não pode ficar em branco'

      comment.valid?

      expect(comment.errors.full_messages).to include error
    end
  end
end
