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

    var maxHP: Int {
        attributes.endurance * 2
    }

    var maxMana: Int {
        attributes.wisdom * 2
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
