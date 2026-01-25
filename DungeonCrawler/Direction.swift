//
//  Direction.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/24/26.
//

enum Direction {
    case forward
    case backwards
    case left
    case right
    
    
    var toCoordinate: Coordinate {
        switch self {
            case .forward: return Coordinate(x: 0, y: 1)
            case .backwards: return Coordinate(x: 0, y: -1)
            case .left: return Coordinate(x: -1, y: 0)
            case .right: return Coordinate(x: 1, y: 0)
        }
    }
}
