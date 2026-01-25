//
//  Player.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/24/26.
//

final class Player {
    var position = Coordinate(x: 0, y: 0)
    
    func move(_ direction: Direction) {
        position += direction
    }
}
