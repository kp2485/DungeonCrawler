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
    var activeConditions: [CombatCondition] = []
    var inventory: [Item] = []
    var equippedWeapon: Weapon?

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

    init(character: MythologicalCharacter) {
        self.name = character.name
        self.title = character.title
        self.attributes = character.baseAttributes
        self.abilities = character.abilities
        self.currentHP = character.baseAttributes.endurance * 2
        self.currentMana = character.baseAttributes.wisdom * 2
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
