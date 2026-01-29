//
//  CombatDelegate.swift
//  DungeonCrawler
//
//  Created by Antigravity on 1/28/26.
//

import Foundation

enum CombatResult {
    case victory
    case defeat
    case escaped
}

protocol CombatDelegate: AnyObject {
    var partyMembers: PartyMembers { get }
    func endCombat(result: CombatResult)
}
