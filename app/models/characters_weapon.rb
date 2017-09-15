# frozen_string_literal: true

class CharactersWeapon < ActiveRecord::Base
  # Relations
  belongs_to :character
  belongs_to :weapon

  # Validations
  validates :character, equipable: true
end
