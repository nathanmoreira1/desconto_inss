class Applicant < ApplicationRecord
  belongs_to :user
  has_one :address, dependent: :destroy

  accepts_nested_attributes_for :address, allow_destroy: true

  validates :name, :cpf, :birthdate, :salary, :discount, presence: true

  def self.ransackable_attributes(auth_object = nil)
    ["birthdate", "cpf", "name"]
  end
end
