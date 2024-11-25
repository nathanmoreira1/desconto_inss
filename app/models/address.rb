class Address < ApplicationRecord
  belongs_to :applicant

  validates :street, :number, :neighborhood, :city, :state, :postal_code, presence: true
end
