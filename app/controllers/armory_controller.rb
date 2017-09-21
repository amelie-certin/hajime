# frozen_string_literal: true

class ArmoryController < ApplicationController
  def index
    @characters = Character.all.collect { |u| [u.name, u.id] }
    @character = Character.includes(:weapons).find(@characters.first[1])
    @weapons = Weapon.all.collect { |u| [u.name, u.id] }
    @equipment = CharactersWeapon.new
  end

  def unequip
    @weapon_id = params[:weapon_id]
    conditions = { weapon_id: @weapon_id, character_id: params[:character_id] }
    CharactersWeapon.find_by(conditions).delete
  end
end
