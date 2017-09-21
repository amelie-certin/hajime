# frozen_string_literal: true

class Battle
  def initialize(character1, character2)
    @fighters = [character1, character2].sort_by { |c| -(c.speed + c.legs * 2) }
    @turn = 0
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable MethodLength
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def run
    until fighters_ko?
      if (current.charisma + rand(-20..20)).positive?
        value = focus_used
        if value > 50
          pp "#{current.name} give a critical hit"
          enemy.hitted current.critical_hit
        elsif value >= 10
          pp "#{current.name} give a punch"
          enemy.hitted current.punch
        elsif value < 10
          pp "#{current.name} hurt himslef"
          current.hitted current.weapon_power
        else
          pp "#{current.name} fails"
        end
      else
        pp "#{current.name} depressed"
      end

      @turn += 1
    end

    @fighters[0].ko? ? @fighters[1] : @fighters[0]
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable MethodLength
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  private

  def focus_used
    current.focus - (current.limbs * 2 + current.weapon_focus + rand(-40..30))
  end

  def current
    @fighters[@turn % 2]
  end

  def enemy
    @fighters[(@turn + 1) % 2]
  end

  def fighters_ko?
    @fighters.map(&:ko?).include? true
  end
end
