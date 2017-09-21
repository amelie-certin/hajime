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

    it 'should not be valid without a name' do
      character = FactoryGirl.build :character, name: nil

      expect(character).to_not be_valid
    end

    describe 'balancable' do
      before :each do
        @error = I18n.t('character.validate.balance')
      end

      it 'should not be valid for a balance lower than 175' do
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
  end

  describe 'Relations' do
    describe 'weapon' do
      it 'may have many weapons' do
        character = FactoryGirl.create :character
        w1 = FactoryGirl.create :weapon, legs: 2
        w2 = FactoryGirl.create :weapon, legs: 2
        character.weapons = [w1, w2]

        expect(Character.find(character.id).weapons).to eq [w1, w2]
      end

      it 'should be valid with free limbs left' do
        character = FactoryGirl.create :character
        weapon = FactoryGirl.build :weapon
        character.weapons << weapon

        expect(character).to be_valid
      end

      it 'should not be valid without free limbs left' do
        character = FactoryGirl.create :character
        weapon = FactoryGirl.build :weapon, arms: 1

        expect { character.weapons << weapon }
          .to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end

  describe 'Methods' do
    describe '#fights' do
      it 'should return fights list' do
        c1 = FactoryGirl.create :character
        c2 = FactoryGirl.create :character, name: 'Grumpy cat'
        f1 = FactoryGirl.create :fight, player: c1, opponent: c2
        f2 = FactoryGirl.create :fight, player: c2, opponent: c1

        expect(c1.fights.map(&:id)).to eq [f1, f2].map(&:id)
        expect(c2.fights.map(&:id)).to eq [f2, f1].map(&:id)
      end
    end

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
      it 'should return false for a balance lower than 175' do
        character = FactoryGirl.build :character, speed: 4  # 172

        expect(character.balanced?).to be false
      end

      it 'should return false for a balance greater than 200' do
        character = FactoryGirl.build :character, speed: 43 # 211

        expect(character.balanced?).to be false
      end

      it 'should return true for a balance between 175..200' do
        character = FactoryGirl.build :character, speed: 22 # 190

        expect(character.balanced?).to be true
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

    describe '#free_limbs' do
      it 'should calculate free arms and free legs without weapon' do
        character = FactoryGirl.create :character

        expect(character.free_limbs).to eq(arms: 0, legs: 4)
      end

      it 'should calculate free arms and free legs with weapons' do
        character = FactoryGirl.create :character
        weapon = FactoryGirl.create :weapon
        character.weapons << weapon

        expect(character.free_limbs).to eq(arms: 0, legs: 0)
      end
    end
  end
end
