module Arena
  class StartBattle
    # Given two fighters
    # When they fight
    # Then there is a combat summary
    def initialize(fighter_repository, fight_repository)
      @fighter_repository = fighter_repository
      @fight_repository = fight_repository
    end

    def call(request_params)
      # Given two fighters
      fighters = @fighter_repository.search_fighters(request_params[:player_id], request_params[:opponent_id])

      # When they fight
      fight = Fight.new(fighters[0], fighters[1])

      # Then there is a combat summary
      summary = fight.start
      @fight_repository.store(summary)
      summary
    end
  end
end
