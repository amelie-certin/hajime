# frozen_string_literal: true

class Character < ActiveRecord::Base
  # Validations
  validate :balanced?
  %i(health defense strength focus speed charisma).each do |stat|
    validates stat, numericality: { greater_than: -1, less_than: 201 }
  end

  # Methodes
  def balanced?
    return unless balance > 200 || balance < 175
    errors.add :balance, I18n.t('character.validate.balance')
  end

  def balance
    [health, defense, strength, focus, speed, charisma].compact.sum
  end

  def random
    value = 200
    %w(health focus strength defense speed).each do |stat|
      random = rand 0..value
      send "#{stat}=", random
      value -= random
    end
    self.charisma = value
  end
end
