//
//  World.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2025.
//

import Combine
import Foundation
import SwiftUI

final class World: ObservableObject {
    @Published private(set) var partyPosition: Coordinate
    @Published private(set) var partyHeading: CompassDirection
    @Published private(set) var currentFloorIndex = 0
    @Published private(set) var enemies: [Enemy] = []

    // Game Log
    @Published private(set) var logs: [String] = []

    // Combat State
    @Published var combatEngine: CombatEngine?
    var isCombatActive: Bool {
        return combatEngine != nil
    }

    private let floors: [Map]
    let partyMembers = PartyMembers()

    func log(_ message: String) {
        logs.append(message)
        if logs.count > 50 { logs.removeFirst() }
        print(message)
    }

    var currentFloor: Map { floors[currentFloorIndex] }
    var enemiesOnCurrentFloor: [Enemy] { enemies }

    var state: WorldState {
        if isCombatActive { return .combat }
        if currentFloor.tileAt(partyPosition) == .winTarget { return .win }
        if partyMembers.alivePartyMembers.isEmpty { return .lose }
        return .undetermined
    }

    init(
        map: Map, partyStartPosition: Coordinate = Coordinate(x: 0, y: 0),
        partyStartHeading: CompassDirection = CompassDirection.north
    ) {
        self.floors = [map]
        self.partyPosition = partyStartPosition
        self.partyHeading = partyStartHeading
    }

    init(
        floors: [Map], partyStartPosition: Coordinate = Coordinate(x: 0, y: 0),
        partyStartHeading: CompassDirection = CompassDirection.north
    ) {
        self.floors = floors
        self.partyPosition = partyStartPosition
        self.partyHeading = partyStartHeading
    }

    func addEnemy(_ position: Coordinate) {
        enemies.append(Enemy(position: position))
    }

    func update(at time: Date) {
        if !isCombatActive {
            checkForEnemyContact()
        }
    }

    func checkForEnemyContact() {
        for enemy in enemies where enemy.isAlive {
            if currentFloor.hasLineOfSight(from: enemy.position, to: partyPosition) {
                if enemy.position == partyPosition || isFacing(enemy: enemy, target: partyPosition)
                {
                    print("Encounter started!")
                    startCombat(with: enemy)
                    return
                }
            }
        }
    }

    private func isFacing(enemy: Enemy, target: Coordinate) -> Bool {
        let dx = target.x - enemy.position.x
        let dy = target.y - enemy.position.y
        switch enemy.heading {
        case .north: return dy < 0
        case .south: return dy > 0
        case .east: return dx > 0
        case .west: return dx < 0
        }
    }

    func startCombat(with enemy: Enemy) {
        // Create an Enemy Group based on the encountered enemy
        // For now, 1 enemy = 1 group of 1
        // Later: "3x Skeletons"
        let group = EnemyGroup(enemies: [enemy], name: enemy.name)

        self.combatEngine = CombatEngine(world: self, enemyGroup: group)
        log("Combat started with \(group.name)!")
    }

    func endCombat(won: Bool) {
        self.combatEngine = nil
        if won {
            log("Victory!")
        } else {
            log("Defeat...")
            // trigger lose state
        }
    }

    func perform(_ command: PartyCommand) {
        // If Combat is active, World mostly ignores standard movement commands
        // or forwards them if we want to allow running via movement keys?
        // For now, blocks standard movement.

        guard combatEngine == nil else {
            print("In combat, use CombatEngine commands.")
            return
        }

        guard state != .win && state != .lose else { return }

        switch command {
        case .move(let direction):
            performMovement(direction)
            checkForEnemyContact()
        case .turnCounterClockwise:
            turnPartyCounterClockwise()
            checkForEnemyContact()
        case .turnClockwise:
            turnPartyClockwise()
            checkForEnemyContact()
        case .wait:
            break
        default:
            print("Command not supported out of combat or handled by UI directly.")
        }
    }

    private func performMovement(_ direction: MovementDirection) {
        let newPosition =
            partyPosition + direction.toCompassDirection(facing: partyHeading).toCoordinate
        switch currentFloor.tileAt(newPosition) {
        case .wall: break
        case .stairsUp:
            currentFloorIndex += 1
            partyPosition = newPosition
        case .stairsDown:
            currentFloorIndex -= 1
            partyPosition = newPosition
        default:
            partyPosition = newPosition
        }
    }

    private func turnPartyClockwise() {
        partyHeading = partyHeading.rotatedClockwise()
    }

    private func turnPartyCounterClockwise() {
        partyHeading = partyHeading.rotatedCounterClockwise()
    }
}

enum WorldState {
    case undetermined
    case win
    case lose
    case combat
}

enum PartyCommand {
    case move(direction: MovementDirection)
    case turnCounterClockwise
    case turnClockwise
    case attack
    case ability(Ability)
    case wait
}

func makeWorld(_ floorStrings: [String]) -> World {
    var enemies = [Coordinate]()
    var startingPosition = Coordinate(x: 0, y: 0)
    var floors = [Map]()

    for floorString in floorStrings {
        let characters = toCharacterMatrix(floorString)
        let startingAndEnemyPositions = findStartingAndEnemyPositions(characters)

        startingPosition = startingAndEnemyPositions.startingPosition ?? startingPosition
        enemies.append(contentsOf: startingAndEnemyPositions.enemies)

        floors.append(Map(characters))
    }

    let world = World(floors: floors, partyStartPosition: startingPosition)

    for enemy in enemies {
        world.addEnemy(enemy)
    }

    return world

    func toCharacterMatrix(_ string: String) -> [[Character]] {
        let lines = string.split(separator: "\n")
            .map { String($0) }

        let characters: [[Character]] = lines.map { line in
            line.map { stringElement in
                stringElement
            }
        }

        return characters
    }

    func findStartingAndEnemyPositions(_ characterMatrix: [[Character]]) -> (
        startingPosition: Coordinate?, enemies: [Coordinate]
    ) {
        // lets try and find a starting position
        var enemies = [Coordinate]()
        var startingPosition: Coordinate?

        for y in 0..<characterMatrix.count {
            for x in 0..<characterMatrix[y].count {
                switch characterMatrix[y][x] {
                case "e": enemies.append(Coordinate(x: x, y: y))
                case "S": startingPosition = Coordinate(x: x, y: y)
                default:
                    break
                }
            }
        }

        return (startingPosition, enemies)
    }
}
