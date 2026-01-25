//
//  Direction.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/24/26.
//

enum Direction {
    case forward
    case backwards
    
    var toCoordinate: Coordinate {
        switch self {
            case .forward: return Coordinate(x: 0, y: 1)
            case .backwards: return Coordinate(x: 0, y: -1)
        }
    }
}
