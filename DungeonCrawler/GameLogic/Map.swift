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
    var objects = [Coordinate: InteractiveObject]()

    private let xRange: ClosedRange<Int>
    private let yRange: ClosedRange<Int>

    init(_ mapArray: [[Character]] = [[]]) {
        var readTiles = [Coordinate: Tile]()
        var readObjects = [Coordinate: InteractiveObject]()
        var minX = Int.max
        var maxX = Int.min
        var minY = Int.max
        var maxY = Int.min

        for row in 0..<mapArray.count {
            for column in 0..<mapArray[0].count {
                let char = mapArray[row][column]
                let coord = Coordinate(x: column, y: row)

                // Parse Objects
                if char == "+" {
                    readObjects[coord] = InteractiveObject(state: .door(.closed))
                    readTiles[coord] = .wall
                } else if char == "O" {
                    readObjects[coord] = InteractiveObject(state: .door(.open))
                    readTiles[coord] = .wall
                } else if char == "L" {
                    readObjects[coord] = InteractiveObject(state: .door(.locked(difficulty: 10)))
                    readTiles[coord] = .wall
                } else if char == "C" {
                    readObjects[coord] = InteractiveObject(state: .chest(.closed))
                    readTiles[coord] = .floor
                } else if char == "l" {
                    readObjects[coord] = InteractiveObject(state: .chest(.locked(difficulty: 10)))
                    readTiles[coord] = .floor
                } else {
                    let tile = Tile.characterToTile(char)
                    readTiles[coord] = tile
                }

                // Update bounds
                minX = min(minX, column)
                maxX = max(maxX, column)
                minY = min(minY, row)
                maxY = max(maxY, row)
            }
        }

        self.tiles = readTiles.filter { $0.value != .floor }
        self.objects = readObjects

        // Default to 0...0 if empty
        if minX == Int.max {
            self.xRange = 0...0
            self.yRange = 0...0
        } else {
            self.xRange = minX...maxX
            self.yRange = minY...maxY
        }
    }

    func tileAt(_ coordinate: Coordinate) -> Tile {
        if !xRange.contains(coordinate.x) || !yRange.contains(coordinate.y) {
            return .wall
        }
        return tiles[coordinate, default: .floor]
    }

    var minX: Int { xRange.lowerBound }
    var maxX: Int { xRange.upperBound }
    var minY: Int { yRange.lowerBound }
    var maxY: Int { yRange.upperBound }

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

            // Check for blocking objects first (Closed Doors)
            if let object = objects[coord] {
                if object.isBlockingSight {
                    return false
                }
                // If it's an object that DOESN'T block sight (like an open door),
                // we treat the wall as transparent.
                // So if there is an object, and it doesn't block sight, we verify if it is a door.
                if case .door(let state) = object.state, state == .open {
                    continue  // Allow sight through open door on wall
                }
            }

            if tileAt(coord) == .wall {
                return false
            }
        }

        return true
    }
}

extension Map: Equatable {}
