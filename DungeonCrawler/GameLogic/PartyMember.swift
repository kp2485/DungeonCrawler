//
//  PartyMember.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 28/06/2025.
//

final class PartyMember: Combatant {
    let name: String
    var currentHP: Int
    var currentInitiative: Int = 0
    let attributes: Attributes

    var maxHP: Int {
        attributes.endurance * 2
    }

    init(name: String, attributes: Attributes = .random) {
        self.name = name
        self.attributes = attributes
        self.currentHP = attributes.endurance * 2
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
