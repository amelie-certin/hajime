# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Weapon do
  describe 'Validations' do
    it 'should not be valid without a name' do
      weapon = FactoryGirl.build :weapon, name: nil

      expect(weapon).to_not be_valid
    end

    it 'should not be valid with a negative stat' do
      w1 = FactoryGirl.build :weapon, arms: -1
      w2 = FactoryGirl.build :weapon, legs: -1
      w3 = FactoryGirl.build :weapon, focus: -1
      w4 = FactoryGirl.build :weapon, power: -1

      expect(w1).to_not be_valid
      expect(w2).to_not be_valid
      expect(w3).to_not be_valid
      expect(w4).to_not be_valid
    end
  end
end
