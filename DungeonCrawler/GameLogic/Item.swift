//
//  Item.swift
//  DungeonCrawler
//
//  Created by Antigravity on 1/28/26.
//

import Foundation

struct Item: Identifiable, Codable {
    var id: UUID = UUID()
    let name: String
    let description: String
    let type: ItemType
    let power: Int  // Heal amount, etc.
}

enum ItemType: String, Codable {
    case potion  // Heals HP
    case manaPotion  // Restores Mana
    case revive  // Revives dead (not implemented yet maybe)
    // case weapon, armor
}
