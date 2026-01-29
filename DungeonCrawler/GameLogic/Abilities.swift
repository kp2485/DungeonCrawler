import Foundation

enum AbilityType: String, Equatable, Codable {
    case damage
    case heal
    case buff  // Increases stats temporarily
    case debuff  // Decreases enemy stats
    case aoe  // Area of effect damage
    case utility  // Special effects
}

enum AbilityTarget: String, Equatable, Codable {
    case singleEnemy
    case allEnemies
    case enemyGroup
    case singleAlly
    case allAllies
    case party
    case selfTarget
}

enum StatusEffectType: String, Equatable, Codable {
    // Buffs
    case strengthUp, enduranceUp, agilityUp, speedUp, intelligenceUp, wisdomUp, dexterityUp,
        constitutionUp, perceptionUp, luckUp, willpowerUp
    case defenseUp, accuracyUp, evasionUp
    case regeneration
    case haste

    // Debuffs
    case strengthDown, enduranceDown, agilityDown, speedDown, intelligenceDown, wisdomDown,
        dexterityDown, constitutionDown, perceptionDown, luckDown, willpowerDown
    case defenseDown, accuracyDown, evasionDown
    case poison
    case burn
    case bleed
    case stun
    case sleep
    case confusion
    case silence
    case slow
    case fear
    case charm
    case blind
}

struct StatusEffectDefinition: Equatable, Hashable, Codable {
    let type: StatusEffectType
    let duration: Int  // In turns
    let magnitude: Int  // For stat changes or damage per turn
    let chance: Double  // 0.0 to 1.0 (probability of application)

    init(type: StatusEffectType, duration: Int, magnitude: Int = 0, chance: Double = 1.0) {
        self.type = type
        self.duration = duration
        self.magnitude = magnitude
        self.chance = chance
    }
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

    // New Fields
    let targetType: AbilityTarget
    let cooldown: Int  // In turns, 0 = no cooldown
    let statusEffects: [StatusEffectDefinition]

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
        weakAgainst: Set<DamageType> = [],
        targetType: AbilityTarget = .singleEnemy,
        cooldown: Int = 0,
        statusEffects: [StatusEffectDefinition] = []
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
        self.targetType = targetType
        self.cooldown = cooldown
        self.statusEffects = statusEffects
    }
}
