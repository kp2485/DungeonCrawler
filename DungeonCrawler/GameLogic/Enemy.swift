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
    var abilities: [Ability] = []

    var currentMana: Int
    var maxMana: Int { attributes.wisdom * 2 }
    var level: Int = 1  // Added for scaling
    var activeConditions: [CombatCondition] = []

    // Combat State
    // var condition: CombatCondition = .normal // Removed in favor of activeConditions

    init(position: Coordinate, attributes: Attributes = .random) {
        self.id = UUID()
        self.position = position
        self.attributes = attributes
        self.currentHP = attributes.endurance * 2
        self.currentMana = attributes.wisdom * 2
        self.name = "Skeleton"
    }

    init(character: MythologicalCharacter, position: Coordinate = Coordinate(x: 0, y: 0)) {
        self.id = UUID()
        self.position = position
        self.attributes = character.baseAttributes
        self.currentHP = character.baseAttributes.endurance * 2
        self.currentMana = character.baseAttributes.wisdom * 2
        self.name = character.name
        // Note: Enemy does not currently have 'abilities' property like PartyMember,
        // preventing full usage of MythologicalCharacter.
        // We should add abilities to Enemy if needed for AI, but for now we follow the existing struct.
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
