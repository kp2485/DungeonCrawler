//
//  Player.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/24/26.
//

final class Player {
    private(set) var position = Coordinate(x: 0, y: 0)
    private(set) var heading = CompassDirection.east
    
    func move(_ direction: Direction) {
        position += direction
    }
    
    func turnClockwise() {
        
    }
}
