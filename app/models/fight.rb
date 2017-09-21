# frozen_string_literal: true

class Fight < ActiveRecord::Base
  # Relations
  belongs_to :player, class_name: :Character, foreign_key: :player_id
  belongs_to :opponent, class_name: :Character, foreign_key: :opponent_id

  # Enum
  enum winner: %i(player opponent draw)

  # Validations
  validates :player, fightable: true

  # Callbacks
  before_create :hajime!

  # Methods
  def hajime!
    battle = Battle.new player, opponent
    survivor = battle.run
    self.winner = survivor.id == player.id ? :player : :opponent
  end
end
