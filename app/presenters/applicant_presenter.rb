class ApplicantPresenter < BasePresenter
  def cpf
    return 'CPF Inválido' if @object.cpf.blank? || @object.cpf.length != 11

    @object.cpf.gsub(/(\d{3})(\d{3})(\d{3})(\d{2})/, '\1.\2.\3-\4')
  end

  def birthdate
    return 'Data Inválida' if @object.birthdate.blank?

    @object.birthdate.strftime('%d/%m/%Y')
  end

  def salary
    number_to_currency(@object.salary, unit: 'R$', separator: ',', delimiter: '.')
  end

  def discount
    number_to_currency(@object.discount, unit: 'R$', separator: ',', delimiter: '.')
  end
end
