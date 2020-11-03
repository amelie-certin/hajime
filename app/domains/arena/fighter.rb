module Arena
  # Domain model
  class Fighter
    attr_reader :name

    def self.from_model(model)
      new(
        Arena::Types::DatabaseIdentifier[model.id],
        model.name,
        Characteristics.new(
          strength: model.strength,
          defense: model.defense,
          health: model.health,
          speed: model.speed,
          charisma: model.charisma
        ),
        model.weapons.map { |ar_weapon| Arena::Weapon.from_model(ar_weapon) }
      )
    end

    def initialize(id, name, characteristics, weapons)
      @database_identifier = id
      @name = name
      @characteristics = characteristics
      @current_health = characteristics.health
    end

    def id
      @database_identifier
    end

    def motivated?
      (@characteristics.charisma + rand(-20..20)).positive?
    end

    def ko?
      @current_health <= 0
    end

    def damages
      [@characteristics.strength, false]
    end

    def take_hit(damages)
      @current_health -= damages
    end

    def speed
      @characteristics.speed
    end
  end
end
