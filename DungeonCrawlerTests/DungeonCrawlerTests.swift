//
//  DungeonCrawlerTests.swift
//  DungeonCrawlerTests
//
//  Created by Kyle Peterson on 1/24/26.
//

import Testing
@testable import DungeonCrawler

@Suite("Player movement should")
struct PlayerMovementTests {
    @Test("move forward when we instruct the player to move forward") func PlayerMoveForward() {
        let player = Player()
        
        player.move(.forward)
        
        #expect(player.position == Coordinate(x:0, y:1))
    }
}
