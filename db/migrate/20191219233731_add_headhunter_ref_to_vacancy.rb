class AddHeadhunterRefToVacancy < ActiveRecord::Migration[6.0]
  def change
    add_reference :vacancies, :headhunter, foreign_key: true
  end
end
