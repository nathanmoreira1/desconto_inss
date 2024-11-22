class Address < ApplicationRecord
    has_many :applicants
  
    validates :street, :number, :neighborhood, :city, :state, :postal_code, presence: true
  end
  