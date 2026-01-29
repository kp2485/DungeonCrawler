//
//  Weapon.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/28/26.
//

import Foundation

enum WeaponMotion: String, Codable {
    case swing = "swings"
    case thrust = "thrusts"
    case bash = "bashes"
    case slash = "slashes"
    case shoot = "shoots"
    case brawl = "punches"  // Unarmed
}

struct Weapon: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let damage: Int  // Base damage
    let accuracyBonus: Int  // Modifies hit chance
    let critChance: Double  // 0.0 to 1.0 (e.g., 0.05 for 5%)
    let motion: WeaponMotion

    // Default Unarmed Weapon
    static let unarmed = Weapon(
        name: "Fists", damage: 1, accuracyBonus: 0, critChance: 0.01, motion: .brawl)
}
