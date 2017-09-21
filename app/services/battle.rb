# frozen_string_literal: true

class Battle
  def initialize(character1, character2)
    @fighters = [character1, character2].sort_by { |c| -(c.speed + c.legs * 2) }
    @turn = 0
    @message = ['<ul>']
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
          critical_hit
        elsif value >= 10
          hit
        elsif value < 10
          critical_fail
        else
          fail
        end
      else
        depressed
      end

      @turn += 1
    end
    @message << '</ul>'
    { winner: @fighters[0].ko? ? @fighters[1] : @fighters[0], resume: @message }
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable MethodLength
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity

  private

  def critical_hit
    @message << "<li>#{current.name} give a critical hit</li>"
    enemy.hitted current.critical_hit
  end

  def hit
    @message << "<li>#{current.name} give a punch</li>"
    enemy.hitted current.punch
  end

  def critical_fail
    @message << "<li>#{current.name} hurt himslef</li>"
    current.hitted current.weapon_power
  end

  def fail
    @message << "<li>#{current.name} fails</li>"
  end

  def depressed
    @message << "<li>#{current.name} depressed</li>"
  end

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
