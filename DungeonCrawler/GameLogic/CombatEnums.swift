//
//  CombatEnums.swift
//  DungeonCrawler
//
//  Created by Antigravity on 1/28/26.
//

import Foundation

enum BattlePosition: String, CaseIterable, Codable {
    case frontLeft
    case frontRight
    case backLeft
    case backRight
    case enemyFront
    case enemyBack
}

enum TargetScope {
    case singleEnemy(Enemy)
    case enemyGroup(EnemyGroup)
    case allEnemies
    case singleAlly(PartyMember)
    case party
    case selfTarget
}

enum CombatAction {
    case attack(target: TargetScope)
    case cast(ability: Ability, powerLevel: Int, target: TargetScope)
    case defend
    case item  // Placeholder for now
    case run
    case wait  // For skips
}

enum CombatPhase {
    case selection  // Player choosing actions
    case execution  // Viewing the round play out
    case victory
    case defeat
}
