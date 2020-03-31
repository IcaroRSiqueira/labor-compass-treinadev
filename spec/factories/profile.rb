FactoryBot.define do
  factory :profile do
    full_name { 'Jose Silva' }
    social_name { 'Jose Silva' }
    birth_date { '12/12/1990' }
    education { 'Graduação em ADS pela FMU' }
    description { 'Curso finalizado em 2015' }
    experience { '3 anos de desenvolvimento back end em ruby' }
    candidate
    trait :with_avatar do
      avatar do
        fixture_file_upload(Rails.root.join("spec/support/assets/nyan.jpg"),
                            'image/jpg')
      end
    end
  end
end
