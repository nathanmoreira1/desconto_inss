class CalculateInssDiscountService
    def self.call(salary)
      new(salary).call
    end

    def initialize(salary)
      @salary = salary
    end

    def call
      calculate_discount(@salary)
    end

    private

    def calculate_discount(salary)
      discount = 0.0
      previous_max = 0.0

      INSS_BRACKETS.each_with_index do |bracket, index|
        next_bracket = INSS_BRACKETS[index + 1]
        range_max = next_bracket ? next_bracket[:max] : salary

        if salary > bracket[:max]
          discount += (bracket[:max] - previous_max) * bracket[:rate]
        else
          discount += (salary - previous_max) * bracket[:rate]
          break
        end

        previous_max = bracket[:max]
      end

      if salary > INSS_BRACKETS.last[:max]
        discount += (salary - INSS_BRACKETS.last[:max]) * INSS_BRACKETS.last[:rate]
      end

      discount.round(2)
    end
end
