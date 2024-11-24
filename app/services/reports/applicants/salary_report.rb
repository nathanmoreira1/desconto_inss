class Reports::Applicants::SalaryReport < Reports::BaseReport
    def generate
      report_data = INSS_BRACKETS.map do |bracket|
        count = Applicant.where(salary: bracket[:min]..bracket[:max]).count
        { label: bracket[:label], count: count }
      end
  
      last_bracket_max = INSS_BRACKETS.last[:max]
      above_last_bracket_count = Applicant.where('salary > ?', last_bracket_max).count
  
      report_data << { label: "Acima de R$ #{last_bracket_max}", count: above_last_bracket_count }
      
      format_data(report_data)
    end
  end
  