class Applicant < ApplicationRecord
  belongs_to :user
  has_one :address

  validates :name, :cpf, :birthdate, :salary, :discount, presence: true
end
