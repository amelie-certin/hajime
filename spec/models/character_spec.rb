# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Character do
  describe 'Validations' do
    it 'should be valid for a balance between 175 and 200' do
      c1 = FactoryGirl.build :character, speed: 32 # 200
      c2 = FactoryGirl.build :character, speed: 7  # 175
      c3 = FactoryGirl.build :character, speed: 33 # 201
      c4 = FactoryGirl.build :character, speed: 6  # 174

      expect(c1).to be_valid
      expect(c2).to be_valid
      expect(c3).to_not be_valid
      expect(c4).to_not be_valid
    end

    it 'should not be valid for a negative stat' do
      character = FactoryGirl.build :character, speed: -1

      expect(character).to_not be_valid
    end

    it 'should not be valid for a negative limb' do
      character = FactoryGirl.build :character, arms: -1, legs: -1

      expect(character).to_not be_valid
    end
  end

  describe 'Methods' do
    describe '#balance' do
      it 'should calculate the stats sum' do
        c1 = FactoryGirl.build :character, speed:     32 # 200
        c2 = FactoryGirl.build :character, charisma:  7  # 171
        c3 = FactoryGirl.build :character, focus:     33 # 204
        c4 = FactoryGirl.build :character, strength:  6  # 185

        expect(c1.balance).to eq 200
        expect(c2.balance).to eq 171
        expect(c3.balance).to eq 204
        expect(c4.balance).to eq 185
      end
    end

    describe '#balanced?' do
      before :each do
        @error = I18n.t('character.validate.balance')
      end

      it 'should add a validation error for a balance lower than 175' do
        character = FactoryGirl.build :character, speed: 4  # 172
        character.valid?

        expect(character.errors[:balance]).to include(@error)
      end

      it 'should add a validation error for a balance greater than 200' do
        character = FactoryGirl.build :character, speed: 43 # 211
        character.valid?

        expect(character.errors[:balance]).to include(@error)
      end

      it 'should not add a validation error for a balance between 175..200' do
        character = FactoryGirl.build :character, speed: 22 # 190
        character.valid?

        expect(character.errors[:balance]).to_not include(@error)
      end
    end

    describe '#random' do
      it 'should always generate stats for a balance of 200' do
        character = FactoryGirl.build :character

        5.times do
          character.random
          expect(character.balance).to eq 200
        end
      end

      it 'should not generate negative stats' do
        character = FactoryGirl.build :character
        stats = %i(health defense strength focus speed charisma)

        5.times do
          character.random
          stats.each do |stat|
            expect(character.send(stat)).to(satisfy { |v| v >= 0 })
          end
        end
      end
    end
  end
end
