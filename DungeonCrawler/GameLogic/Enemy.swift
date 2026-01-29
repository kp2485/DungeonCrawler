//
//  Enemy.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 26/07/2025.
//

import Foundation

final class Enemy: Combatant, Identifiable {
    let id: UUID
    let position: Coordinate
    var heading: CompassDirection = .east

    let name: String
    var currentHP: Int
    var maxHP: Int { attributes.endurance * 2 }
    var currentInitiative: Int = 0
    var attributes: Attributes

    // Combat State
    var condition: CombatCondition = .normal

    init(position: Coordinate, attributes: Attributes = .random) {
        self.id = UUID()
        self.position = position
        self.attributes = attributes
        self.currentHP = attributes.endurance * 2

        // TODO: Randomize name based on type later
        self.name = "Skeleton"
    }

    // Conformance to Equatable (via checking ID)
    static func == (lhs: Enemy, rhs: Enemy) -> Bool {
        return lhs.id == rhs.id
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

    // Legacy attack (will be replaced by CombatEngine)
    func attack(_ partyMember: PartyMember) {
        partyMember.takeDamage(1)
    }
}

enum CombatCondition: String, Codable {
    case normal
    case asleep
    case paralyzed
    case dead
}

struct EnemyGroup: Identifiable {
    let id: UUID
    var enemies: [Enemy]
    var name: String  // e.g., "3x Skeletons"

    var isAlive: Bool {
        return enemies.contains { $0.isAlive }
    }

    init(enemies: [Enemy], name: String) {
        self.id = UUID()
        self.enemies = enemies
        self.name = name
    }

    var livingCount: Int {
        enemies.filter { $0.isAlive }.count
    }
}
