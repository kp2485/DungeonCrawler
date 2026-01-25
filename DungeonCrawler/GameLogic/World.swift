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

    // Combat State
    @Published var turnQueue: [Combatant] = []
    @Published var activeCombatantIndex: Int = 0
    @Published var isCombatActive: Bool = false

    private let floors: [Map]
    let partyMembers = PartyMembers()

    var currentFloor: Map {
        floors[currentFloorIndex]
    }

    var enemiesOnCurrentFloor: [Enemy] {
        enemies
    }

    var state: WorldState {
        if isCombatActive { return .combat }

        if currentFloor.tileAt(partyPosition) == .winTarget {
            return .win
        }

        if partyMembers.alivePartyMembers.isEmpty {
            return .lose
        }

        return .undetermined
    }

    var activeCombatant: Combatant? {
        guard isCombatActive, !turnQueue.isEmpty else { return nil }
        return turnQueue[activeCombatantIndex % turnQueue.count]
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
        // Real-time updates paused during combat
        if !isCombatActive {
            checkForEnemyContact()
        }
    }

    func checkForEnemyContact() {
        for enemy in enemies where enemy.isAlive {
            if currentFloor.hasLineOfSight(from: enemy.position, to: partyPosition) {
                print("Enemy spotted player! initiating combat.")
                startCombat()
                return
            }
        }
    }

    func startCombat() {
        isCombatActive = true
        var combatants: [Combatant] = partyMembers.alivePartyMembers
        // Add nearby enemies to combat
        let nearbyEnemies = enemies.filter {
            $0.isAlive && currentFloor.hasLineOfSight(from: $0.position, to: partyPosition)
        }
        combatants.append(contentsOf: nearbyEnemies)

        // Roll Initiative
        for combatant in combatants {
            combatant.rollInitiative()
        }

        // Sort by Initiative Descending, re-rolling ties implicitly by stable sort order if equal, but just speed for now
        turnQueue = combatants.sorted {
            if $0.currentInitiative == $1.currentInitiative {
                return $0.attributes.speed > $1.attributes.speed
            }
            return $0.currentInitiative > $1.currentInitiative
        }

        activeCombatantIndex = 0
        processTurn()
    }

    func processTurn() {
        guard let current = activeCombatant else { return }

        if let enemy = current as? Enemy {
            // Enemy Turn Logic
            print("Enemy \(enemy.name) taking turn.")
            // Simple logic: If adjacent, attack random member. If not, move closer.
            if enemy.position.manhattanDistanceTo(partyPosition) <= 1 {
                if let target = partyMembers.alivePartyMembers.randomElement() {
                    enemy.attack(target)
                    print("Enemy attacked \(target.name)")
                }
            } else {
                // Move towards player (simple)
                // In a real grid, A* would be better, but we will simply move towards player x then y
                // For now, enemy movement shouldn't teleport, so we skip complex pathfinding
            }

            endTurn()
        } else {
            // Player Turn: Wait for input
            print("Player's turn: \(current.name)")
        }
    }

    func endTurn() {
        activeCombatantIndex = (activeCombatantIndex + 1) % turnQueue.count

        // Remove dead combatants
        turnQueue = turnQueue.filter { $0.isAlive }
        if turnQueue.isEmpty || !turnQueue.contains(where: { $0 is Enemy }) {
            print("Combat ended. Victory!")
            isCombatActive = false
            return
        }
        if !turnQueue.contains(where: { $0 is PartyMember }) {
            print("Combat ended. Defeat!")
            isCombatActive = false  // Will switch to .lose state
            return
        }

        processTurn()
    }

    func perform(_ command: PartyCommand) {
        guard canPerformAction else { return }

        // If in combat, only allow action if it is a PartyMember's turn (conceptually)
        // For simplicity, any input during Player Turn counts as the "Active" Party Member's action
        if isCombatActive {
            if activeCombatant is PartyMember {
                switch command {
                case .attack:
                    performAttack()
                    endTurn()
                case .wait:
                    print("Player waited.")
                    endTurn()
                default:
                    print("Movement not yet implemented in combat (costs turn?)")
                    // For now, let's say movement ends turn too
                    switch command {
                    case .move(let direction):
                        performMovement(direction)
                        endTurn()
                    case .turnCounterClockwise:
                        turnPartyCounterClockwise()
                    // turning is free? or ends turn? let's make it free for now
                    case .turnClockwise:
                        turnPartyClockwise()
                    default: break
                    }
                }
            }
            return
        }

        // Out of Combat
        switch command {
        case .move(let direction):
            performMovement(direction)
            checkForEnemyContact()  // Check after move
        case .turnCounterClockwise:
            turnPartyCounterClockwise()
            checkForEnemyContact()  // Check after turn (fov change?)
        case .turnClockwise:
            turnPartyClockwise()
            checkForEnemyContact()
        case .attack:
            performAttack()  // Can initiate combat? or just whack air
        case .wait:
            break
        }
    }

    func performAttack() {
        // Attack tile in front
        let targetPos = partyPosition + partyHeading.toCoordinate
        if let enemy = enemies.first(where: { $0.position == targetPos && $0.isAlive }) {
            // Calculate Damage based on attributes?
            // For now fixed
            enemy.takeDamage(5)
            print("Attacked enemy at \(targetPos), it took damage.")
            if !enemy.isAlive {
                print("Enemy defeated!")
            }
            // If not in combat, this should start combat if not dead?
            if !isCombatActive && enemy.isAlive {
                startCombat()
            }
        } else {
            print("Swung at nothing.")
        }
    }

    private var canPerformAction: Bool {
        state != .win && state != .lose
    }

    private func performMovement(_ direction: MovementDirection) {
        let newPosition =
            partyPosition + direction.toCompassDirection(facing: partyHeading).toCoordinate

        switch currentFloor.tileAt(newPosition) {

        case .wall:
            break
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
