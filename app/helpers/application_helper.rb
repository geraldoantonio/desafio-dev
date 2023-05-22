# frozen_string_literal: true

module ApplicationHelper
  def flash_class(key)
    options = {
      'notice' => 'success',
      'alert' => 'warning',
      'error' => 'danger'
    }

    options[key]
  end

  def money(number)
    ActiveSupport::NumberHelper.number_to_currency(
      number,
      unit: 'R$',
      separator: ',',
      delimiter: '.',
      negative_format: '- %u %n'
    )
  end

  def cpf_humanized(cpf)
    return unless cpf.present?

    CPF.new(cpf).formatted
  end
end
