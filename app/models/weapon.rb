# frozen_string_literal: true

class Weapon < ActiveRecord::Base
  # Validations
  validates :name, presence: true
  %i(arms legs focus power).each do |requirement|
    validates requirement, numericality: { greater_than_or_equal_to: 0 }
  end
end
