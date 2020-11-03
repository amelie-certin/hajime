module Arena
  # Value Object -> immutable
  class Characteristics < Dry::Struct
    attribute :strength, Types::Strict::Integer
    attribute :defense, Types::Strict::Integer
    attribute :health, Types::Strict::Integer
    attribute :speed, Types::Strict::Integer
    attribute :charisma, Types::Strict::Integer
  end
end
