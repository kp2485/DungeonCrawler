//
//  CombatVisualEffect.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/28/26.
//

import Foundation

struct CombatVisualEvent: Identifiable, Equatable {
    let id = UUID()
    let type: CombatVisualEffect
}

enum CombatVisualEffect: String, Equatable {
    case shake
    case flashRed
    case flashGreen
}
