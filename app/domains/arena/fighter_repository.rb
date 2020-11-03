module Arena
  class FighterRepository
    def initialize(scope = ::Character.all)
      @scope = scope
    end

    def search_fighters(fighter_1_id, fighter_2_id)
      # preload => Aggregate
      chars = @scope.preload(:weapons).where(id: [fighter_1_id, fighter_2_id])

      raise FighterCountError, "required 2 fighters, get #{chars.count}" if chars.count != 2

      chars.map { |c| Fighter.from_model(c) }
    end
  end
end
