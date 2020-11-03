module Arena
  # Domain model
  # Value Object
  class Weapon < Dry::Struct
    attribute :name, Types::Strict::String
    attribute :arms, Types::Strict::Integer
    attribute :legs, Types::Strict::Integer
    attribute :focus, Types::Strict::Integer
    attribute :power, Types::Strict::Integer

    def self.from_model(model)
      new(
        name: model.name,
        arms: model.arms,
        legs: model.legs,
        focus: model.focus,
        power: model.power
      )
    end
  end
end
