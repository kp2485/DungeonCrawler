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
    @Test("movement in a specified direction gets to the expected coordinate", arguments: [
        (Direction.forward, Coordinate(x: 0, y: 1)),
        (Direction.backwards, Coordinate(x: 0, y: -1))
    ]) func PlayerMoveForward(testcase: (direction: Direction, expectedPosition: Coordinate)) {
        let player = Player()
        
        player.move(testcase.direction)
        
        #expect(player.position == testcase.expectedPosition)
    }
    
    @Test("move forward twice to get to coordinate (0,2)") func PlayerMoveForwardTwice() {
        let player = Player()
        
        player.move(.forward)
        player.move(.forward)
        
        #expect(player.position == Coordinate(x:0, y:2))
    }
}
