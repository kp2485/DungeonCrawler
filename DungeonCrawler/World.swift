//
//  World.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/24/26.
//

import simd

class World {
    var playerPosition: SIMD3<Float> = .zero
    
    func moveForward() {
        playerPosition = [playerPosition.x, playerPosition.y, playerPosition.z - 1]
        print("New player position: \(playerPosition)")
    }
    
    func moveBackward() {
        playerPosition = [playerPosition.x, playerPosition.y, playerPosition.z + 1]
        print("New player position: \(playerPosition)")
    }
}
