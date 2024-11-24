class Reports::ApplicantsController < ApplicationController
    def index ; end
    def salary
      report_service = Reports::Applicants::SalaryReport.new
      @brackets = report_service.generate
      render "reports/applicants/salary/index"
    end
end
