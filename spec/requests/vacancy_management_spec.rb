require 'rails_helper'

describe 'Vacancy Management' do
  context 'show' do
    it 'renders vacancy correctly' do
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456',
                                      name: 'Teste Enterprises')
      vacancy = Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                                skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                                end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable)

      get api_v1_vacancy_path(vacancy)
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:headhunter_id]).to eq(vacancy.headhunter_id)
      expect(json[:title]).to eq(vacancy.title)
      expect(json[:description]).to eq(vacancy.description)
      expect(json[:skill]).to eq(vacancy.skill)
      expect(json[:wage]).to eq(vacancy.wage)
      expect(json[:role]).to eq(vacancy.role)
      expect(json[:location]).to eq(vacancy.location)
    end

    it 'car not found' do
      get api_v1_vacancy_path(999)

      expect(response).to have_http_status(:not_found)
    end
  end
end
