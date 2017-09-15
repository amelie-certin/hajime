# frozen_string_literal: true

class EquipableValidator < ActiveModel::EachValidator
  def validate_each(record, _attribute, value)
    return unless too_many_arms_weapon? value.free_limbs, record.weapon
    record.errors[:weapon_quantity] << 'Too many weapons'
  end

  private

  def too_many_arms_weapon?(free_limbs, weapon)
    return true if free_limbs[:arms] < weapon.arms ||
                   free_limbs[:legs] < weapon.legs
    false
  end
end
