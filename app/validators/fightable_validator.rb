# frozen_string_literal: true

class FightableValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, value)
    return unless same_character? record.opponent, value
    translate = I18n.t('character.validate.same_character')
    record.errors[:same_character] << translate
  end

  private

  def same_character?(character, opponent)
    character&.id == opponent&.id ? true : false
  end
end
