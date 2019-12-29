class AddVisibilityToVacancy < ActiveRecord::Migration[6.0]
  def change
    add_column :vacancies, :visibility, :integer, defeault: 0
  end
end
