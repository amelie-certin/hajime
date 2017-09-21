# frozen_string_literal: true

class CharacterController < ApplicationController
  def new
    @character = Character.new
    @character.random
  end

  def show
    @character = Character.includes(:weapons).find(params[:id])
  end

  def create
    Character.create! permit_params(params)
    redirect_to controller: :enter_arena, action: :index
  end

  def permit_params(params)
    list = %i(name strength health defense focus speed charisma avatar
              arms legs)
    params.require(:character).permit(list)
  end
end
