class CreateAddresses < ActiveRecord::Migration[8.0]
  def change
    create_table :addresses do |t|
      t.string :street
      t.string :number
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :postal_code

      t.references :applicant, null: false, foreign_key: true # Referência para Applicant

      t.timestamps
    end
  end
end
