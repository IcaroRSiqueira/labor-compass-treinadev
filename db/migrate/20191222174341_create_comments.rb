class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :body
      t.date :comment_date

      t.timestamps
    end
  end
end
