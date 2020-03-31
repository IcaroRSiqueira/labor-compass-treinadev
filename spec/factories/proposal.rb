FactoryBot.define do
  factory :proposal do
    start_date { 20.day.from_now }
    workload { 'Segunda a sexta-feira, das 9 as 17h' }
    benefits { 'Vale transporte e alimentação' }
    wage { 'R$ 3000,00 ao mês' }
    details { "O candidato deverá trabalhar junto a equipe de desenvolvimento" }
    entry
    candidate
    headhunter
  end
end
