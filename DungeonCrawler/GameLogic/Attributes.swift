import Foundation

enum AttributeType: String, CaseIterable, Codable {
    case strength
    case endurance
    case agility
    case speed
    case intelligence
    case wisdom
    case dexterity
    case constitution
    case perception
    case luck
    case willpower
}

struct Attributes: Equatable, Codable {
    var strength: Int
    var endurance: Int
    var agility: Int
    var speed: Int
    var intelligence: Int
    var wisdom: Int
    var dexterity: Int
    var constitution: Int
    var perception: Int
    var luck: Int
    var willpower: Int

    static var random: Attributes {
        return Attributes(
            strength: Int.random(in: 3...18),
            endurance: Int.random(in: 3...18),
            agility: Int.random(in: 3...18),
            speed: Int.random(in: 3...18),
            intelligence: Int.random(in: 3...18),
            wisdom: Int.random(in: 3...18),
            dexterity: Int.random(in: 3...18),
            constitution: Int.random(in: 3...18),
            perception: Int.random(in: 3...18),
            luck: Int.random(in: 3...18),
            willpower: Int.random(in: 3...18)
        )
    }

    subscript(attribute: AttributeType) -> Int {
        get {
            switch attribute {
            case .strength: return strength
            case .endurance: return endurance
            case .agility: return agility
            case .speed: return speed
            case .intelligence: return intelligence
            case .wisdom: return wisdom
            case .dexterity: return dexterity
            case .constitution: return constitution
            case .perception: return perception
            case .luck: return luck
            case .willpower: return willpower
            }
        }
        set {
            switch attribute {
            case .strength: strength = newValue
            case .endurance: endurance = newValue
            case .agility: agility = newValue
            case .speed: speed = newValue
            case .intelligence: intelligence = newValue
            case .wisdom: wisdom = newValue
            case .dexterity: dexterity = newValue
            case .constitution: constitution = newValue
            case .perception: perception = newValue
            case .luck: luck = newValue
            case .willpower: willpower = newValue
            }
        }
    }
}

func rollDie(sides: Int) -> Int {
    return Int.random(in: 1...sides)
}

protocol Combatant: AnyObject {
    var id: UUID { get }
    var name: String { get }
    var currentHP: Int { get set }
    var maxHP: Int { get }
    var attributes: Attributes { get }
    var currentInitiative: Int { get set }
    var isAlive: Bool { get }

    func rollInitiative()
    var currentMana: Int { get set }
    var maxMana: Int { get }
    var activeConditions: [CombatCondition] { get set }

    func hasCondition(_ condition: CombatCondition) -> Bool

    func takeDamage(_ amount: Int)
}

extension Combatant {
    // Default implementation for checking specific condition existence ignoring associated values for some cases if needed,
    // but for now strict equality is fine or we can add helper methods.
    func hasCondition(_ condition: CombatCondition) -> Bool {
        return activeConditions.contains(condition)
    }
}

enum CombatCondition: Equatable, Codable {
    case poison(Int)  // Damage per turn
    case asleep  // Skip turn, wakes on damage
    case paralyzed  // Skip turn, chance to wear off
    case blind  // Accuracy penalty
    case silenced  // Cannot cast spells
    case buff(AttributeType, Int)  // Attribute, Amount
    case debuff(AttributeType, Int)  // Attribute, Amount
    case defending  // Reduced damage taken until next turn
    case dead  // HP <= 0

    var name: String {
        switch self {
        case .poison: return "Poison"
        case .asleep: return "Asleep"
        case .paralyzed: return "Paralyzed"
        case .blind: return "Blind"
        case .silenced: return "Silenced"
        case .buff(let attr, _): return "\(attr.rawValue.capitalized) Up"
        case .debuff(let attr, _): return "\(attr.rawValue.capitalized) Down"
        case .defending: return "Defending"
        case .dead: return "Dead"
        }
    }

    // Equatable conformance for associated values
    static func == (lhs: CombatCondition, rhs: CombatCondition) -> Bool {
        switch (lhs, rhs) {
        case (.poison(let a), .poison(let b)): return a == b
        case (.asleep, .asleep): return true
        case (.paralyzed, .paralyzed): return true
        case (.blind, .blind): return true
        case (.silenced, .silenced): return true
        case (.buff(let a1, let v1), .buff(let a2, let v2)): return a1 == a2 && v1 == v2
        case (.debuff(let a1, let v1), .debuff(let a2, let v2)): return a1 == a2 && v1 == v2
        case (.defending, .defending): return true
        case (.dead, .dead): return true
        default: return false
        }
    }
}
