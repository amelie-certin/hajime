# frozen_string_literal: true

FactoryGirl.define do
  factory :fight do
    winner 'player'
    player { FactoryGirl.create :character }
    opponent { FactoryGirl.create :character, name: 'Grumpy Cat' }
  end
end
