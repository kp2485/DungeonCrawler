//
//  Profession.swift
//  DungeonCrawler
//
//  Created by User on 2026-01-29.
//

import Foundation

enum Sex: String, Codable, CaseIterable {
    case male = "Male"
    case female = "Female"
    case hermaphrodite = "Hermaphrodite"
}

enum Gender: String, Codable, CaseIterable {
    case male = "Male"
    case female = "Female"
    case hermaphrodite = "Hermaphrodite"
    case eunuch = "Eunuch"
}

struct Profession: Codable, Equatable, Identifiable {
    var id: String { name }
    let name: String
    let description: String
    let requiredAttributes: Attributes
    let startingAbilities: [Ability]  // Using existing Ability struct
    let genderRequirement: Gender?  // If nil, any gender allowed. Strictly enforces GENDER, not SEX.

    // Helper to check requirements
    func canBePickedBy(gender: Gender) -> Bool {
        if let req = genderRequirement {
            return req == gender
        }
        return true
    }

    static let allProfessions: [Profession] = [
        // Military & Combat
        Profession(
            name: "Hoplite",
            description:
                "A heavy infantryman, master of the spear and shield (aspis). They form the backbone of the phalanx.",
            requiredAttributes: Attributes(
                strength: 12, endurance: 12, agility: 0, speed: 0, intelligence: 0, wisdom: 0,
                dexterity: 0, constitution: 12, perception: 0, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Peltast",
            description:
                "A light skirmisher armed with javelins and a crescent shield (pelte). Excellent at harassing enemies.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 12, speed: 12, intelligence: 0, wisdom: 0,
                dexterity: 10, constitution: 0, perception: 0, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Toxotes",
            description:
                "A dedicated archer, often from Crete or Scythia. They rain death from a distance.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 0, speed: 10, intelligence: 0, wisdom: 0,
                dexterity: 14, constitution: 0, perception: 12, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Psiloi",
            description:
                "A slinger or stone thrower. Lowly but dangerous, they disrupt enemy formations.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 12, speed: 0, intelligence: 0, wisdom: 0,
                dexterity: 12, constitution: 0, perception: 0, luck: 12, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Ekdromos",
            description:
                "A 'runner-out', a light hoplite specialized in breaking formation to chase down skirmishers.",
            requiredAttributes: Attributes(
                strength: 10, endurance: 0, agility: 10, speed: 14, intelligence: 0, wisdom: 0,
                dexterity: 0, constitution: 0, perception: 0, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Somatophylax",
            description:
                "A royal bodyguard, sworn to protect their charge with their life. Extremely durable.",
            requiredAttributes: Attributes(
                strength: 12, endurance: 14, agility: 0, speed: 0, intelligence: 0, wisdom: 0,
                dexterity: 0, constitution: 14, perception: 0, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Epibates",
            description:
                "A marine or sea-soldier. Accustomed to fighting on the rocking decks of triremes.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 10, agility: 12, speed: 0, intelligence: 0, wisdom: 0,
                dexterity: 0, constitution: 10, perception: 0, luck: 10, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Misthophoros",
            description: "A veteran mercenary who fights for coin. Versatile and pragmatic.",
            requiredAttributes: Attributes(
                strength: 10, endurance: 10, agility: 0, speed: 0, intelligence: 0, wisdom: 0,
                dexterity: 0, constitution: 10, perception: 0, luck: 10, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Lestes",
            description: "A bandit or brigand. Masters of ambush and dirty fighting.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 12, speed: 12, intelligence: 0, wisdom: 0,
                dexterity: 0, constitution: 0, perception: 0, luck: 12, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Makhairophoros",
            description:
                "A swordsman or duelist, wielding the kopis or makhaira with deadly skill.",
            requiredAttributes: Attributes(
                strength: 10, endurance: 0, agility: 12, speed: 0, intelligence: 0, wisdom: 0,
                dexterity: 12, constitution: 0, perception: 0, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),

        // Civic & Intellectual
        Profession(
            name: "Philosopher",
            description:
                "A seeker of truth. They use logic and rhetoric to dismantle their opponents' resolve.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 0, speed: 0, intelligence: 14, wisdom: 12,
                dexterity: 0, constitution: 0, perception: 0, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Rhetor",
            description:
                "An orator and politician. Their words can charm friends and confuse enemies.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 0, speed: 0, intelligence: 12, wisdom: 0,
                dexterity: 0, constitution: 0, perception: 0, luck: 0, willpower: 12),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Sophist",
            description:
                "A teacher of virtue and rhetoric, often for a fee. They empower allies with knowledge.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 0, speed: 0, intelligence: 12, wisdom: 0,
                dexterity: 0, constitution: 0, perception: 0, luck: 10, willpower: 10),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Grammateus",
            description:
                "A scribe or administrator. Master of scrolls, glyphs, and ancient knowledge.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 0, speed: 0, intelligence: 14, wisdom: 0,
                dexterity: 0, constitution: 0, perception: 12, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Pedagogue",
            description:
                "A strict teacher or disciplinarian. They ensure the party performs at their best.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 0, speed: 0, intelligence: 10, wisdom: 12,
                dexterity: 0, constitution: 0, perception: 0, luck: 0, willpower: 12),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Architect",  // Tecton
            description:
                "A builder and engineer. Capable of constructing fortifications and understanding mechanics.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 0, speed: 0, intelligence: 14, wisdom: 0,
                dexterity: 12, constitution: 0, perception: 0, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),

        // Religious & Arts
        Profession(
            name: "Hierophant",
            description: "A high priest of mysteries. They channel divine power to banish evil.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 0, speed: 0, intelligence: 0, wisdom: 14,
                dexterity: 0, constitution: 0, perception: 0, luck: 0, willpower: 12),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Mantis",  // Oracle
            description: "A seer and diviner. They foresee danger and twist fate in their favor.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 0, speed: 0, intelligence: 0, wisdom: 14,
                dexterity: 0, constitution: 0, perception: 14, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Dadouchos",
            description: "A torch-bearer of the Eleusinian mysteries. They wield fire and light.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 10, speed: 0, intelligence: 0, wisdom: 12,
                dexterity: 0, constitution: 0, perception: 0, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Aoidos",
            description: "A bard or epic singer. Their songs inspire courage and terrifying dread.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 0, speed: 0, intelligence: 0, wisdom: 10,
                dexterity: 0, constitution: 0, perception: 0, luck: 12, willpower: 12),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Hypokrites",
            description: "An actor or thespian. Master of disguise and mimicry.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 10, speed: 0, intelligence: 0, wisdom: 0,
                dexterity: 0, constitution: 0, perception: 14, luck: 0, willpower: 10),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Telestai",
            description: "A ritual initiator. They summon spirits and perform complex rites.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 0, speed: 0, intelligence: 10, wisdom: 14,
                dexterity: 0, constitution: 0, perception: 0, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),

        // Trades & Commoners
        Profession(
            name: "Athlete",  // Pankratiast
            description: "An unarmed combat champion. Expert in wrestling and boxing (Pankration).",
            requiredAttributes: Attributes(
                strength: 14, endurance: 12, agility: 12, speed: 0, intelligence: 0, wisdom: 0,
                dexterity: 0, constitution: 12, perception: 0, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Iatros",  // Physician
            description: "A man of medicine. Uses herbs and surgery to keep the party alive.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 0, speed: 0, intelligence: 14, wisdom: 12,
                dexterity: 10, constitution: 0, perception: 0, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Rhizotomos",
            description: "A root-cutter and herbalist. Expert in preparing potions and poisons.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 0, speed: 0, intelligence: 12, wisdom: 10,
                dexterity: 10, constitution: 0, perception: 12, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Kynegetes",  // Hunter
            description: "A tracker and beast slayer. At home in the wild.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 10, agility: 0, speed: 10, intelligence: 0, wisdom: 0,
                dexterity: 0, constitution: 0, perception: 14, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Halieus",  // Fisherman
            description: "Master of nets and tridents. Capable of entangling foes.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 10, speed: 0, intelligence: 0, wisdom: 0,
                dexterity: 12, constitution: 0, perception: 0, luck: 10, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Chalkeus",
            description: "A smith and metalworker. Keeps weapons sharp and armor strong.",
            requiredAttributes: Attributes(
                strength: 14, endurance: 0, agility: 0, speed: 0, intelligence: 0, wisdom: 0,
                dexterity: 0, constitution: 14, perception: 0, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Emporos",
            description: "A merchant or traveler. Uses wealth and connections to survive.",
            requiredAttributes: Attributes(
                strength: 0, endurance: 0, agility: 0, speed: 0, intelligence: 0, wisdom: 10,
                dexterity: 0, constitution: 0, perception: 10, luck: 14, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
        Profession(
            name: "Helot",
            description:
                "An oppressed laborer, hardened by a difficult life. Surprisingly resilient.",
            requiredAttributes: Attributes(
                strength: 10, endurance: 14, agility: 0, speed: 0, intelligence: 0, wisdom: 0,
                dexterity: 0, constitution: 14, perception: 0, luck: 0, willpower: 0),
            startingAbilities: [],
            genderRequirement: nil
        ),
    ]
}
