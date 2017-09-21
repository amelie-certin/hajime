# frozen_string_literal: true

class EnterArenaController < ApplicationController
  def index
    @characters = Character.all
    @list = @characters.collect { |c| [c.name, c.id] }
    @fight = Fight.new
  end
end
