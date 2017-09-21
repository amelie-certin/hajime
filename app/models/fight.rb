# frozen_string_literal: true

class Fight < ActiveRecord::Base
  # Relations
  belongs_to :player, class_name: :Character, foreign_key: :player_id
  belongs_to :opponent, class_name: :Character, foreign_key: :opponent_id

  # Enum
  enum winner: %i(player opponent)

  # Validations
  validates :player, fightable: true

  # Callbacks
  before_create :hajime!

  # Methods
  def hajime!
    battle = Battle.new player, opponent
    battle = battle.run
    self.winner = battle[:winner].id == player.id ? :player : :opponent
    self.resume = battle[:resume].join
  end

  def winner_character
    player? ? player : opponent
  end
end
