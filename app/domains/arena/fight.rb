module Arena
  # Domain model
  class Fight
    def initialize(fighter_1, fighter_2)
      @fighter_1 = fighter_1
      @fighter_2 = fighter_2
    end

    def start
      turn = 0
      logs = []

      fight_order = [@fighter_1, @fighter_2].sort_by(&:speed)

      until fighters_ko?
        attacker = find_attacker(fight_order, turn)
        defender = find_defenser(fight_order, turn)

        logs << make_turn(attacker, defender)

        turn += 1
      end

      FightSummary.new(winner: winner, loser: loser, logs: logs)
    end

    def winner
      @fighter_1.ko? ? @fighter_2 : @fighter_1
    end

    def loser
      @fighter_1.ko? ? @fighter_1 : @fighter_2
    end

    private

    def make_turn(attacker, defender)
      damages, is_critical = attacker.damages
      damage_taken = defender.take_hit(damages)

      action = {
        attacker_damages: damages,
        is_attack_critical: is_critical,
        defender_damage_taken: damage_taken
      }

      { attacker: attacker.name, defender: defender.name, action: action }
    end

    def fighters_ko?
      @fighter_1.ko? || @fighter_2.ko?
    end

    def find_attacker(order, turn)
      order[turn % 2]
    end

    def find_defenser(order, turn)
      order[(turn + 1) % 2]
    end
  end
end
