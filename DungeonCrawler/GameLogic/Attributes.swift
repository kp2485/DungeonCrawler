
import Foundation

enum AttributeType: String, CaseIterable {
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

struct Attributes: Equatable {
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
    var name: String { get }
    var currentHP: Int { get set }
    var maxHP: Int { get }
    var attributes: Attributes { get }
    var currentInitiative: Int { get set }
    var isAlive: Bool { get }
    
    func rollInitiative()
    func takeDamage(_ amount: Int)
}
