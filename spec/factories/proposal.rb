FactoryBot.define do
  factory :proposal do
    start_date { 20.day.from_now }
    workload { 'Segunda a sexta-feira, das 9 as 17h' }
    benefits { 'Vale transporte e alimentação' }
    wage { 'R$ 3000,00 ao mês' }
    details { 'A desenvolvedora deverá trabalhar junto a equipe de desenvolvimento adicionando as features exigidas ao sistema da empresa, favor, enviar telefone para contato no campo mensagem adicional' }
    entry
    candidate
    headhunter
  end
end
