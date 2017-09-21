# frozen_string_literal: true

class Character < ActiveRecord::Base
  # Relations
  has_many :characters_weapons
  has_many :weapons, through: :characters_weapons

  # Validations
  validates :name, presence: true
  validates :avatar, presence: true
  validates :strength, balancable: true

  %i(health defense strength focus speed charisma).each do |stat|
    validates stat, numericality: { greater_than_or_equal_to: 0,
                                    less_than_or_equal_to: 200 }
  end

  %i(arms legs).each do |limb|
    validates limb, numericality: { greater_than_or_equal_to: 0 }
  end

  # Paperclip
  has_attached_file :avatar, styles: { medium: '300x300#', thumb: '100x100#' }
  validates_attachment_content_type :avatar, content_type: %r{image\/.*}

  # Methods
  def fights
    Fight.where 'player_id = ? OR opponent_id = ?', id, id
  end

  def balanced?
    balance <= 200 && balance >= 175
  end

  def balance
    [health, defense, strength, focus, speed, charisma].compact.sum
  end

  def random
    value = 200
    %w(health focus strength defense speed).each do |stat|
      random = rand 0..value
      send "#{stat}=", random
      value -= random
    end
    self.charisma = value
  end

  def free_limbs
    { arms: arms - weapons.map(&:arms).sum,
      legs: legs - weapons.map(&:legs).sum }
  end

  def limbs
    arms + legs
  end

  def ko?
    health.zero?
  end

  def hitted(damage)
    damage = (damage - defense).positive? ? (damage - defense).to_i : 5
    self.health -= damage < self.health ? damage : self.health
  end

  def critical_hit
    punch + 10
  end

  def punch
    weapon_power + strength
  end

  def weapon_power
    weapons.map(&:power).sum
  end

  def weapon_focus
    weapons.map(&:focus).sum
  end
end
