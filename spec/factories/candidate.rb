FactoryBot.define do
  factory :candidate do
    email { "test#{rand}@candidate.com" }
    password { '12345678' }
  end
end
