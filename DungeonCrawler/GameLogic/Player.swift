//
//  Player.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/24/26.
//

final class Player {
    private(set) var position = Coordinate(x: 0, y: 0)
    private(set) var heading = CompassDirection.north
    
    func move(_ direction: MovementDirection) {
        position += direction.toCompassDirection(facing: heading).toCoordinate
    }
    
    func turnClockwise() {
        heading = heading.rotatedClockwise()
    }
    
    func turnCounterclockwise() {
        heading = heading.rotatedClockwise().rotatedClockwise().rotatedClockwise()
    }
}
