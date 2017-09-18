# frozen_string_literal: true

class Weapon < ActiveRecord::Base
  # Relations
  belongs_to :player, class_name: :Character, foreign_key: true
  belongs_to :opponent, class_name: :Character, foreign_key: true

  # Enum
  enum winner: %i(player opponent draw)

  # Validations
  validates :winner, presence: true
end
