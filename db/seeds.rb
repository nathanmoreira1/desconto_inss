require 'faker'

User.create(
    email: 'master@admin.com', password: '12345678', password_confirmation: '12345678'
)

50.times do
    applicant = Applicant.new(
        name: Faker::Name.name,
        cpf: Faker::Number.number(digits: 11),
        birthdate: Faker::Date.birthday(min_age: 18, max_age: 65),
        salary: Faker::Number.between(from: 0, to: 9500).round(2),  # Salário entre 0 e 9500
        user_id: User.last.id
    )

    applicant.build_address(
        street: Faker::Address.street_address,
        number: Faker::Address.building_number,
        neighborhood: Faker::Address.community,
        city: Faker::Address.city,
        state: Faker::Address.state_abbr,
        postal_code: Faker::Address.postcode
    )

    applicant.discount = CalculateInssDiscountService.call(applicant.salary)

    applicant.save
end
