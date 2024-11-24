class CreateApplicants < ActiveRecord::Migration[8.0]
  def change
    create_table :applicants do |t|
      t.string :name
      t.string :cpf
      t.date :birthdate
      t.decimal :salary
      t.decimal :discount

      t.references :user, null: false, foreign_key: true # Referência para User

      t.timestamps
    end
  end
end
