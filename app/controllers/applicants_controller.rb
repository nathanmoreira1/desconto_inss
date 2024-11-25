class ApplicantsController < ApplicationController
  before_action :set_applicant, only: [ :edit, :update, :destroy ]
  before_action :set_discount, only: [ :update ]

  def index
    @q = Applicant.ransack(params[:q])
    @applicants = @q.result.page(params[:page]).per(10)
  end

  def new
    @applicant = Applicant.new
    @applicant.build_address
  end

  def create
    @applicant = Applicant.new(applicant_params)
    @applicant.discount = calculate_discount(@applicant.salary.to_f)
    @applicant.user = current_user
    if @applicant.save
      redirect_to applicants_path, notice: "Proponente criado com sucesso."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @applicant.update(applicant_params)
      redirect_to applicants_path, notice: "Proponente atualizado com sucesso."
    else
      render :edit
    end
  end

  def destroy
    @applicant.destroy
    redirect_to applicants_path, notice: "Proponente excluído com sucesso."
  end

  def calculate_inss
    salary = params[:salary].to_f
    discount = CalculateInssDiscountService.call(salary)
    render json: { discount: discount }
  end

  private

  def set_applicant
    @applicant = Applicant.find(params[:id])
  end

  def calculate_discount(salary)
    return 0 if salary.nil?

    CalculateInssDiscountService.call(salary)
  end

  def set_discount
    @applicant.discount = calculate_discount(applicant_params[:salary].to_f)
  end

  def applicant_params
    params.require(:applicant).permit(
      :name, :cpf, :birthdate, :salary,
      address_attributes: [ :id, :street, :number, :neighborhood, :city, :state, :postal_code ]
    )
  end
end
