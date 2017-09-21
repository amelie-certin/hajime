# frozen_string_literal: true

class BalancableValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, _value)
    return if record.balanced?
    record.errors[:balance] << I18n.t('character.validate.balance')
  end
end
