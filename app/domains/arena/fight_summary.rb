module Arena
  # Value Object
  class FightSummary < Dry::Struct
    attribute :winner, Types.Instance(Arena::Fighter)
    attribute :loser, Types.Instance(Arena::Fighter)
    attribute :logs, Types::Strict::Array

    def logs_as_html
      '<ul>' + logs.map { |log| "<li>#{log}</li>" }.join('<br>') + '</ul>'
    end
  end
end
