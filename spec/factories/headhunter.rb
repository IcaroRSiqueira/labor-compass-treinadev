FactoryBot.define do
  factory :headhunter do
    email { "headhunter#{rand()}@test.com" }
    password { '12345678' }
    name { 'Test Enterprises' }
  end
end
