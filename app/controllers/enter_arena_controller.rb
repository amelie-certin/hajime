# frozen_string_literal: true

class EnterArenaController < ApplicationController
  def index
    @characters = Character.all
  end
end
