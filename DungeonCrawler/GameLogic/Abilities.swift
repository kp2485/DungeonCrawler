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
    let id = UUID()
    let name: String
    let description: String
    let manaCost: Int
    let type: AbilityType
    let power: Int  // magnitude of effect (damage amount, heal amount, stat boost amount)
    let attributeScaling: AttributeType  // Which attribute scales this ability

    // For Equatable/Hashable to ignore UUID if needed, but default is fine for unique instances
    static func == (lhs: Ability, rhs: Ability) -> Bool {
        lhs.name == rhs.name && lhs.type == rhs.type
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(type)
    }
}
