# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Fight do
  describe 'Validations' do
    it 'should not be valid without a player' do
      fight = FactoryGirl.build :fight, player: nil

      expect(fight).to_not be_valid
    end

    it 'should not be valid without a opponent' do
      fight = FactoryGirl.build :fight, opponent: nil

      expect(fight).to_not be_valid
    end

    it 'should not be valid with the same fighter' do
      character = FactoryGirl.create :character
      fight = FactoryGirl.build :fight, opponent: character, player: character
      error = I18n.t('character.validate.same_character')

      expect(fight).to_not be_valid
      expect(fight.errors[:same_character]).to include(error)
    end
  end

  describe 'Relations' do
    it 'should have a player and an opponent' do
      fight = FactoryGirl.build :fight

      expect(fight).to be_valid
    end
  end
end
