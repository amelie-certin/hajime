# frozen_string_literal: true

class Fight < ActiveRecord::Base
  # Relations
  belongs_to :player, class_name: :Character, foreign_key: :player_id
  belongs_to :opponent, class_name: :Character, foreign_key: :opponent_id

  # Enum
  enum winner: %i(player opponent draw)

  # Validations
  validates :winner, presence: true
  validates :player, fightable: true
end
