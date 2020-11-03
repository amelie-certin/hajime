module Arena
  class FightRepository
    def store(fight_summary)
      fight = ::Fight.create({
        player_id: fight_summary.winner.id,
        opponent_id: fight_summary.loser.id,
        winner: 0,
        resume: fight_summary.logs_as_html
      })
    end
  end
end
