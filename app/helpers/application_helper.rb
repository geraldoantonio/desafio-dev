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
end
