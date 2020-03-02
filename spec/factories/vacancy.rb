FactoryBot.define do
  factory :vacancy do
    title { 'Desenvolvedor Web' }
    description { 'Desenvilvimento de paginas web com ruby on rails' }
    skill { 'Experiencia com ruby on rails' }
    wage { 'wage' }
    role { 'Junior' }
    end_date { 15.day.from_now }
    location { 'Av. Paulista' }
    headhunter
  end
end
