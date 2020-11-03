module Arena
  module Types
    include Dry.Types()

    DatabaseIdentifier = Types::Strict::Integer | Types::Strict::Nil
  end
end
