//
//  Enemy.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 26/07/2025.
//

import Foundation

final class Enemy: Combatant {
    let position: Coordinate
    let heading: CompassDirection = .east

    let name = "Skeleton"
    var currentHP: Int
    var maxHP: Int { attributes.endurance * 2 }
    var currentInitiative: Int = 0
    var attributes: Attributes

    init(position: Coordinate, attributes: Attributes = .random) {
        self.position = position
        self.attributes = attributes
        self.currentHP = attributes.endurance * 2
    }

    var isAlive: Bool {
        currentHP > 0
    }

    func takeDamage(_ amount: Int) {
        currentHP = max(0, currentHP - amount)
    }

    func rollInitiative() {
        currentInitiative = rollDie(sides: 20) + attributes.speed
    }

    func attack(_ partyMember: PartyMember) {
        // Simple attack logic
        partyMember.takeDamage(1)
    }
}
