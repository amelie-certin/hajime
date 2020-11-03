# frozen_string_literal: true

class FightController < ApplicationController
  def create
    @summary = Arena::StartBattle.new(
      Arena::FighterRepository.new,
      Arena::FightRepository.new
    ).call(fight_permit_params)
  end

  def fight_permit_params
    params.require(:fight).permit(:player_id, :opponent_id)
  end
end
