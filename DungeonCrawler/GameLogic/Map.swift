//
//  Map.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 29/03/2025.
//

enum Tile {
    case floor
    case wall
    case stairsUp
    case stairsDown
    case winTarget

    static func characterToTile(_ character: Character) -> Tile {
        switch character {
        case "#": return .wall
        case "<": return .stairsUp
        case ">": return .stairsDown
        case "T": return .winTarget
        default: return .floor
        }
    }
}

struct Map {
    private var tiles = [Coordinate: Tile]()

    var minX: Int {
        tiles.keys.map { $0.x }.min() ?? 0
    }

    var minY: Int {
        tiles.keys.map { $0.y }.min() ?? 0
    }

    var maxX: Int {
        tiles.keys.map { $0.x }.max() ?? 0
    }

    var maxY: Int {
        tiles.keys.map { $0.y }.max() ?? 0
    }

    init(_ mapArray: [[Character]] = [[]]) {
        var readTiles = [Coordinate: Tile]()
        for row in 0..<mapArray.count {
            for column in 0..<mapArray[0].count {
                readTiles[Coordinate(x: column, y: row)] = Tile.characterToTile(
                    mapArray[row][column])
            }
        }

        self.tiles = readTiles.filter { $0.value != .floor }
    }

    func tileAt(_ coordinate: Coordinate) -> Tile {
        tiles[coordinate, default: .floor]
    }

    func hasLineOfSight(from start: Coordinate, to end: Coordinate) -> Bool {
        let distance = start.manhattanDistanceTo(end)
        if distance == 0 { return true }
        if distance > 10 { return false }  // Limit sight range

        let dx = end.x - start.x
        let dy = end.y - start.y
        let steps = max(abs(dx), abs(dy))

        for i in 1...steps {
            let t = Float(i) / Float(steps)
            let x = Int(Float(start.x) + Float(dx) * t + 0.5)
            let y = Int(Float(start.y) + Float(dy) * t + 0.5)

            let coord = Coordinate(x: x, y: y)
            if coord == end { return true }

            if tileAt(coord) == .wall {
                return false
            }
        }

        return true
    }
}

extension Map: Equatable {}
