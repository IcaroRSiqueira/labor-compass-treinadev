class AddStatusToVacancy < ActiveRecord::Migration[6.0]
  def change
    add_column :vacancies, :status, :integer, default: 0
  end
end
