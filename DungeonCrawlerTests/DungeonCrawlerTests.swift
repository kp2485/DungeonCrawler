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
        (Direction.backwards, Coordinate(x: 0, y: -1)),
        (Direction.left, Coordinate(x: -1, y: 0)),
        (Direction.right, Coordinate(x: 1, y: 0))
    ]) func movePlayerForward(testcase: (direction: Direction, expectedPosition: Coordinate)) {
        let player = Player()
        
        player.move(testcase.direction)
        
        #expect(player.position == testcase.expectedPosition)
    }
    
    @Test("move forward twice to get to coordinate (0,2)") func movePlayerForwardTwice() {
        let player = Player()
        
        player.move(.forward)
        player.move(.forward)
        
        #expect(player.position == Coordinate(x:0, y:2))
    }
    
    @Test("returns to initial position after moving forward, right, back and then left") func moveInACircle() {
        let player = Player()
        
        player.move(.forward)
        player.move(.right)
        player.move(.backwards)
        player.move(.left)
        
        #expect(player.position == Coordinate(x:0, y:0))
    }
}

@Suite("Player rotation should") struct PlayerRotationTests {
    @Test("face north when the new player is created") func newPlayerFacesNorth() {
        let player = Player()
        
        
        
        #expect(player.heading == .north)
    }
    
    @Test("face east when it turns clockwise") func turnClockwiseOnce() {
        let player = Player()
        
        player.turnClockwise()
        
        #expect(player.heading == .east)
    }
    
    @Test("face west when it turns clockwise three times") func turnClockwiseThreeTimes() {
        let player = Player()
        
        player.turnClockwise()
        player.turnClockwise()
        player.turnClockwise()
        
        #expect(player.heading == .west)
    }
    
    @Test("face west when turning counterclockwise once") func turnCounterclockwise() {
        let player = Player()
        
        player.turnCounterclockwise()
        
        #expect(player.heading == .west)
    }
}
