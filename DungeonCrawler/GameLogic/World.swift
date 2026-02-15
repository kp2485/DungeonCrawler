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

    private var floors: [Map]
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

        // 1. Check for Object Interaction (Bump to Open)
        if var object = currentFloor.objects[newPosition] {
            if case .door(let state) = object.state {
                switch state {
                case .open:
                    // If open, we can pass through, EVEN IF IT IS A WALL
                    break
                case .closed:
                    // Unlock/Open automatically
                    object.state = InteractiveObjectState.door(.open)
                    updateObject(object, at: newPosition)
                    log("You open the door.")
                    return  // Open on bump, don't move yet
                case .locked:
                    log("The door is locked.")
                    return  // Block movement
                }
            } else if case .chest = object.state {
                log("You see a chest.")
                return
            }
        }

        // 2. Auto-Close Logic (Check previous tile)
        // If we are moving successfully, check if we are leaving a tile with an open door
        // We do this BEFORE updating partyPosition, so 'partyPosition' is still the "old" tile.
        if let object = currentFloor.objects[partyPosition],
            case .door(let state) = object.state,
            case .open = state
        {

            // Scheduling the close for AFTER the move?
            // Actually, we can just close it now. The player is "leaving" it.
            // But wait, if we are "in" the door tile, and we move "out", it should close behind us.
            // Logic: Update object at 'partyPosition' to be closed.

            var closedDoor = object
            closedDoor.state = .door(.closed)
            updateObject(closedDoor, at: partyPosition)
            // log("The door closes behind you.")
            // Logging might be spammy if moving back and forth, but let's leave it out or generic.
        }

        // 3. Move Logic
        // We already checked for blocking objects above.
        // Now if it is a wall, we can only move if there is an OPEN DOOR there (which we also checked effectively by breaking above)
        // Wait, 'break' above just exits the object check.
        // We need to verify if we SHOULD stop for a wall.

        // If there is an open door at newPosition, treat it as floor.
        let hasOpenDoor =
            (currentFloor.objects[newPosition]?.state ?? .chest(.closed)) == .door(.open)

        let targetTile = currentFloor.tileAt(newPosition)

        switch targetTile {
        case .wall:
            if hasOpenDoor {
                partyPosition = newPosition
                checkForRandomEncounter()
            } else {
                // Blocked
            }
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

    // MARK: - Interaction Logic

    // Mutate floor state
    private func updateObject(_ object: InteractiveObject, at coordinate: Coordinate) {
        // floors is currently immutable 'let'. We need to fix that.
        // Assuming I fix 'floors' definition to 'var' below/above.
        var map = floors[currentFloorIndex]
        map.objects[coordinate] = object
        floors[currentFloorIndex] = map
    }

    func getObjectInFront() -> (Coordinate, InteractiveObject)? {
        let target = partyPosition + partyHeading.toCoordinate
        if let object = currentFloor.objects[target] {
            return (target, object)
        }
        return nil
    }

    // Called by UI to resolve complex interaction
    func interact(with coordinate: Coordinate, method: InteractionMethod, member: PartyMember) {
        guard var object = currentFloor.objects[coordinate] else { return }

        // Simple resolution for prototype
        // In real game: Check stats vs Difficulty

        switch object.state {
        case .door(let state):
            if case .locked(let difficulty) = state {
                resolveLockInteraction(
                    method: method, difficulty: difficulty, member: member, object: &object,
                    coordinate: coordinate)
            } else if case .closed = state {
                // Bash/Pick on closed but unlocked door? Just open it.
                object.state = InteractiveObjectState.door(.open)
                updateObject(object, at: coordinate)
                log("\(member.name) opens the door.")
            }
        case .chest(let state):
            if case .locked(let difficulty) = state {
                resolveLockInteraction(
                    method: method, difficulty: difficulty, member: member, object: &object,
                    coordinate: coordinate)
            } else if case .closed = state {
                openChest(object: &object, coordinate: coordinate)
            }
        default:
            log("Nothing to do here.")
        }
    }

    private func resolveLockInteraction(
        method: InteractionMethod, difficulty: Int, member: PartyMember,
        object: inout InteractiveObject, coordinate: Coordinate
    ) {
        let success: Bool
        switch method {
        case .bash:
            // Strength check
            let roll = Int.random(in: 1...20) + (member.attributes.strength / 2)
            success = roll >= difficulty
            log("\(member.name) attempts to bash... \(success ? "Success!" : "Failed.")")
        case .pick:
            // Dexterity check
            let roll = Int.random(in: 1...20) + (member.attributes.dexterity / 2)
            success = roll >= difficulty
            log("\(member.name) attempts to pick the lock... \(success ? "Success!" : "Failed.")")
        case .spell:
            // Always success for now if they have mana?
            success = true
            log("\(member.name) casts Knock! Success!")
        case .item:
            // Check for key?
            success = true  // customized later
            log("\(member.name) uses a key. Success!")
        }

        if success {
            if case .door = object.state {
                object.state = InteractiveObjectState.door(.open)
            } else if case .chest = object.state {
                // Chest becomes Open (and looted?)
                openChest(object: &object, coordinate: coordinate)
                return  // openChest handles update
            }
            updateObject(object, at: coordinate)
        }
    }

    private func openChest(object: inout InteractiveObject, coordinate: Coordinate) {
        object.state = InteractiveObjectState.chest(.open)
        log("Chest opened! Found: \(object.content.map{$0.name}.joined(separator: ", "))")
        // Give items
        for item in object.content {
            // Give to first member or party pool?
            // partyMembers.give(item) - implementation detail
            // For now just log
        }
        object.content = []  // Empty it
        updateObject(object, at: coordinate)
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
