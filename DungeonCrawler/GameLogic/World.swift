//
//  World.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2025.
//

import Combine
import Foundation
import SwiftUI

final class World: ObservableObject, CombatDelegate {
    @Published private(set) var partyPosition: Coordinate
    @Published private(set) var partyHeading: CompassDirection
    @Published private(set) var currentFloorIndex = 0
    @Published private(set) var enemies: [Enemy] = []

    // Crystal Ball Statuses
    @Published var enchantedBladeActive: Bool = false
    @Published var armorplateActive: Bool = false
    @Published var magicScreenActive: Bool = false
    @Published var detectSecretActive: Bool = false
    @Published var levitationActive: Bool = false

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
        // No per-frame update needed for turn-based movement right now
    }

    func startCombat(with enemy: Enemy) {
        // Create an Enemy Group based on the encountered enemy
        // For now, 1 enemy = 1 group of 1
        // Later: "3x Skeletons"
        let group = EnemyGroup(enemies: [enemy], name: enemy.name)

        self.combatEngine = CombatEngine(delegate: self, enemyGroup: group)
        log("Combat started with \(group.name)!")
    }

    func endCombat(result: CombatResult) {
        self.combatEngine = nil
        switch result {
        case .victory:
            log("Victory!")
        case .defeat:
            log("Defeat...")
        // trigger lose state
        case .escaped:
            log("Escaped combat!")
        }
    }

    func perform(_ command: PartyCommand) {
        // If Combat is active, World mostly ignores standard movement commands
        // or forwards them if we want to allow running via movement keys?
        // For now, blocks standard movement.

        if let engine = combatEngine {
            // Forward Combat Commands
            // We need to map PartyCommand to CombatAction
            // But PartyCommand is generic.
            switch command {
            case .attack:
                // Default attack: Attack random or first?
                // For prototype: Attack first alive enemy
                if let target = engine.enemyGroup.enemies.first(where: { $0.isAlive }) {
                    if let member = engine.currentSelectionMember {
                        engine.selectAction(
                            for: member, action: .attack(target: .singleEnemy(target)))
                    }
                }
            case .wait:  // Parry/Defend
                if let member = engine.currentSelectionMember {
                    engine.selectAction(for: member, action: .defend)
                }
            // case .ability(let ability): ... handle spells later
            default:
                print("Invalid combat command or not implemented.")
            }
            return
        }

        guard state != .win && state != .lose else { return }

        switch command {
        case .move(let direction):
            performMovement(direction)
        case .turnCounterClockwise:
            turnPartyCounterClockwise()
        case .turnClockwise:
            turnPartyClockwise()
        case .wait:
            break
        default:
            print("Command not supported out of combat.")
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
            checkForRandomEncounter()
        }
    }

    private func checkForRandomEncounter() {
        // Simple random check: 20% chance
        if Int.random(in: 1...100) <= 20 {
            generateRandomEncounter()
        }
    }

    private func generateRandomEncounter() {
        // Pick 1-3 random enemies
        let count = Int.random(in: 1...3)
        var enemies: [Enemy] = []

        for _ in 0..<count {
            if let character = GreekPantheon.allCharacters.randomElement() {
                enemies.append(Enemy(character: character, position: partyPosition))
            }
        }

        if !enemies.isEmpty {
            let names = enemies.map { $0.name }.joined(separator: ", ")
            let groupName = "\(enemies.count)x Enemies (\(names))"
            let group = EnemyGroup(enemies: enemies, name: groupName)

            // Start combat
            combatEngine = CombatEngine(delegate: self, enemyGroup: group)
            log("Encountered \(groupName)!")
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
                case "S": startingPosition = Coordinate(x: x, y: y)
                default:
                    break
                }
            }
        }

        return (startingPosition, enemies)
    }
}
