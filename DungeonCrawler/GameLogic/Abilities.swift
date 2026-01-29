import Foundation

enum AbilityType: String, Equatable, Codable {
    case damage
    case heal
    case buff  // Increases stats temporarily
    case debuff  // Decreases enemy stats
    case aoe  // Area of effect damage
    case utility  // Special effects
}

struct Ability: Equatable, Hashable, Codable {
    var id = UUID()
    let name: String
    let description: String
    let manaCost: Int
    let type: AbilityType
    let power: Int  // magnitude of effect (damage amount, heal amount, stat boost amount) or base modifier
    let attributeScaling: AttributeType  // Which attribute scales this ability
    let diceRoll: String  // e.g., "1d6", "2d8", "1d12+2"
    let damageType: DamageType
    let strongAgainst: Set<DamageType>
    let weakAgainst: Set<DamageType>

    // For Equatable/Hashable to ignore UUID if needed, but default is fine for unique instances
    static func == (lhs: Ability, rhs: Ability) -> Bool {
        lhs.name == rhs.name && lhs.type == rhs.type
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(type)
    }

    // Default init helper to avoid breaking too much code during transition, OR just full init
    init(
        id: UUID = UUID(), name: String, description: String, manaCost: Int, type: AbilityType,
        power: Int, attributeScaling: AttributeType, diceRoll: String = "1d4",
        damageType: DamageType = .physical, strongAgainst: Set<DamageType> = [],
        weakAgainst: Set<DamageType> = []
    ) {
        self.name = name
        self.description = description
        self.manaCost = manaCost
        self.type = type
        self.power = power
        self.attributeScaling = attributeScaling
        self.diceRoll = diceRoll
        self.damageType = damageType
        self.strongAgainst = strongAgainst
        self.weakAgainst = weakAgainst
    }
}
