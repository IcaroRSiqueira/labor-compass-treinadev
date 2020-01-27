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

  context 'index' do
    it 'render vacancies index' do
      headhunter = Headhunter.create!(email: 'test@test.com', password: '123456', name: 'Teste Enterprises')
      vacancy = [
        Vacancy.create!(title: 'Desenvolvedor Web', description: 'Desenvilvimento de paginas web com ruby on rails',
                      skill: 'Experiencia com ruby on rails', wage: '3000', role: 'Junior',
                      end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable),
        Vacancy.create!(title: 'Desenvolvedor Web2', description: 'Desenvilvimento de paginas web com ruby on rails2',
                      skill: 'Experiencia com ruby on rails2', wage: '30002', role: 'Junior2',
                      end_date: 15.day.from_now, location: 'Av Paulista', headhunter: headhunter, status: :avaiable),
        Vacancy.create!(title: 'Desenvolvedor Web3', description: 'Desenvilvimento de paginas web com ruby on rails3',
                      skill: 'Experiencia com ruby on rails3', wage: '30003', role: 'Junior3',
                      end_date: 15.day.from_now, location: 'Av Paulista3', headhunter: headhunter, status: :avaiable)
                  ]
      get api_v1_vacancies_path
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[0][:headhunter_id]).to eq(vacancy[0].headhunter_id)
      expect(json[0][:title]).to eq(vacancy[0].title)
      expect(json[0][:description]).to eq(vacancy[0].description)
      expect(json[0][:skill]).to eq(vacancy[0].skill)
      expect(json[0][:wage]).to eq(vacancy[0].wage)
      expect(json[0][:role]).to eq(vacancy[0].role)
      expect(json[0][:location]).to eq(vacancy[0].location)

      expect(json[1][:headhunter_id]).to eq(vacancy[1].headhunter_id)
      expect(json[1][:title]).to eq(vacancy[1].title)
      expect(json[1][:description]).to eq(vacancy[1].description)
      expect(json[1][:skill]).to eq(vacancy[1].skill)
      expect(json[1][:wage]).to eq(vacancy[1].wage)
      expect(json[1][:role]).to eq(vacancy[1].role)
      expect(json[1][:location]).to eq(vacancy[1].location)

      expect(json[2][:headhunter_id]).to eq(vacancy[2].headhunter_id)
      expect(json[2][:title]).to eq(vacancy[2].title)
      expect(json[2][:description]).to eq(vacancy[2].description)
      expect(json[2][:skill]).to eq(vacancy[2].skill)
      expect(json[2][:wage]).to eq(vacancy[2].wage)
      expect(json[2][:role]).to eq(vacancy[2].role)
      expect(json[2][:location]).to eq(vacancy[2].location)
    end
    
    it 'vacancy not found' do
      get api_v1_vacancies_path
      json = JSON.parse(response.body, symbolize_names: true)

      expect(json).to be_empty
    end
  end
end
