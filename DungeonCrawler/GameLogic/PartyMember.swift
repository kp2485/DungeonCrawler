//
//  PartyMember.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 28/06/2025.
//

import Foundation

final class PartyMember: Combatant, Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let title: String
    var currentHP: Int
    var currentMana: Int
    var currentInitiative: Int = 0
    var attributes: Attributes
    let abilities: [Ability]
    var activeConditions: [ActiveCondition] = []
    var cooldowns: [UUID: Int] = [:]
    var inventory: [Item] = []
    var equippedWeapon: Weapon?

    var sex: Sex
    var gender: Gender
    var professions: [Profession]

    // Derived from professions or just name?
    // let title: String // We can keep title as a stored property, initialized to Profession Name

    var maxHP: Int {
        attributes.endurance * 2
    }

    var maxMana: Int {
        attributes.wisdom * 2
    }

    var currentXP: Int = 0
    var nextLevelXP: Int = 100  // Simplified

    func addXP(_ amount: Int) {
        currentXP += amount
        // Simple level up logic
        while currentXP >= nextLevelXP {
            currentXP -= nextLevelXP
            nextLevelXP = Int(Double(nextLevelXP) * 1.5)
            // Ideally increase stats here
            attributes.strength += 1
            attributes.endurance += 1
            // maxHP = attributes.endurance * 2  // Force update if needed or just use computed
            currentHP = maxHP
            // Log this? CombatEngine handles logs.
        }
    }

    init(name: String, sex: Sex, profession: Profession, attributes: Attributes) {
        self.name = name
        self.title = profession.name
        self.sex = sex

        // Default gender matches sex
        switch sex {
        case .male: self.gender = .male
        case .female: self.gender = .female
        case .hermaphrodite: self.gender = .hermaphrodite
        }

        self.professions = [profession]
        self.attributes = attributes
        self.abilities = profession.startingAbilities
        self.currentHP = attributes.endurance * 2
        self.currentMana = attributes.wisdom * 2
    }

    func takeDamage(_ amount: Int) {
        currentHP = max(0, currentHP - amount)
    }

    var isAlive: Bool {
        currentHP > 0
    }

    func rollInitiative() {
        currentInitiative = rollDie(sides: 20) + attributes.speed
    }
}
