//
//  ViewModel.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 29/03/2025.
//

import AppKit
import Combine
import Foundation
import QuartzCore
import simd

final class ViewModel: ObservableObject {
    let world: World
    @Published var worldState: WorldState
    @Published var partyStats: PartyStats

    @Published var isCombatActive: Bool = false
    @Published var turnQueue: [String] = []  // Just names for now for the UI
    @Published var activeCombatantName: String?
    @Published var activeAbilities: [Ability] = []
    @Published var gameLog: [String] = []

    // Combat UI State
    @Published var currentSelectionMember: PartyMember?
    @Published var availableEnemies: [Enemy] = []

    @Published var availablePartyMembers: [PartyMember] = []

    // Visual Effects
    @Published var lastVisualEffect: CombatVisualEffect?
    private var lastObservedEffectId: UUID?

    // Store cancellables if we use Combine, or just poll in update
    private var cancellables = Set<AnyCancellable>()

    init(world: World) {
        self.world = world
        worldState = world.state
        self.partyStats = PartyStats(partyMembers: world.partyMembers)

        let displayLink = NSScreen.main?.displayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .current, forMode: .common)

        // Initial log
        gameLog.append("Welcome to the Dungeon.")
    }

    @objc func update() {
        // Sync World Log
        if gameLog.count != world.logs.count {
            gameLog = world.logs
        }

        let updatedStats = PartyStats(partyMembers: world.partyMembers)
        if updatedStats != partyStats {
            partyStats = updatedStats
        }

        // Update Combat State
        if isCombatActive != world.isCombatActive {
            isCombatActive = world.isCombatActive
        }

        if let engine = world.combatEngine {
            // In Combat
            // Merge combat logs? Or just display them?
            // For now, let's append combat engine logs to our view model game log if distinct
            if engine.combatLog.count > 0 {
                // Naive sync: take last few?
                // Actually, let's just show engine logs in the main log for now
                // In a real app we'd have separate UI
            }

            // Turn Queue
            let newQueue = engine.turnQueue.map { "\($0.name) (Init: \($0.currentInitiative))" }
            if turnQueue != newQueue {
                turnQueue = newQueue
            }

            // Active Combatant (Execution) or Selecting Member (Selection)
            if let selecting = engine.currentSelectionMember {
                if currentSelectionMember?.id != selecting.id {
                    currentSelectionMember = selecting
                    activeCombatantName = "Choosing: \(selecting.name)"
                    activeAbilities = selecting.abilities
                }

                // Update targets while selecting
                if availableEnemies.map({ $0.id }) != engine.enemyGroup.enemies.map({ $0.id }) {
                    availableEnemies = engine.enemyGroup.enemies
                }
                if availablePartyMembers.map({ $0.id })
                    != engine.delegate.partyMembers.allPartyMembers.map({ $0.id })
                {
                    availablePartyMembers = engine.delegate.partyMembers.allPartyMembers
                }
            } else if let active = engine.activeCombatant {
                // Not selecting: show active combatant
                currentSelectionMember = nil
                if activeCombatantName != active.name {
                    activeCombatantName = active.name
                }
                if let pm = active as? PartyMember {
                    if activeAbilities != pm.abilities {
                        activeAbilities = pm.abilities
                    }
                } else {
                    activeAbilities = []
                }

                // Update targets while executing
                if availableEnemies.map({ $0.id }) != engine.enemyGroup.enemies.map({ $0.id }) {
                    availableEnemies = engine.enemyGroup.enemies
                }
                if availablePartyMembers.map({ $0.id })
                    != engine.delegate.partyMembers.allPartyMembers.map({ $0.id })
                {
                    availablePartyMembers = engine.delegate.partyMembers.allPartyMembers
                }
            } else {
                // Neither selecting nor active combatant
                activeCombatantName = nil
                activeAbilities = []
                currentSelectionMember = nil
            }

            // Visual Effects
            // Visual Effects
            // Check for new effects based on unique ID
            if let event = engine.lastEffect {
                if event.id != lastObservedEffectId {
                    lastObservedEffectId = event.id
                    lastVisualEffect = event.type
                }
            }

        } else {
            // Out of Combat
            if !turnQueue.isEmpty { turnQueue = [] }
            activeCombatantName = nil
            if !activeAbilities.isEmpty { activeAbilities = [] }
        }
    }
}

extension Coordinate {
    var toSIMD3: SIMD3<Float> {
        .init(Float(x), 0, -Float(y))
    }
}

extension CompassDirection {
    var toFloatQuaternion: simd_quatf {
        let angleAroundYAxis: Float =
            switch self {
            case .north:
                0
            case .east:
                .pi * 1.5
            case .south:
                .pi
            case .west:
                .pi * 0.5
            }

        return simd_quatf(angle: angleAroundYAxis, axis: [0, 1, 0])
    }
}

struct PartyStats {
    let members: [PartyMemberStats]

    init(partyMembers: PartyMembers) {
        members = partyMembers.allPartyMembers.map { PartyMemberStats(partyMember: $0) }
    }

    subscript(partyPosition: PartyPosition) -> PartyMemberStats {
        switch partyPosition {
        case .frontLeft:
            members[0]
        case .frontRight:
            members[1]
        case .backLeft:
            members[2]
        case .backRight:
            members[3]
        }
    }
}

struct PartyMemberStats {
    let name: String
    let title: String
    let currentHP: Int
    let maxHP: Int
    let currentMana: Int
    let maxMana: Int

    init(partyMember: PartyMember) {
        self.name = partyMember.name
        self.title = partyMember.title
        self.currentHP = partyMember.currentHP
        self.maxHP = partyMember.maxHP
        self.currentMana = partyMember.currentMana
        self.maxMana = partyMember.maxMana
    }
}

extension PartyStats: Equatable {}
extension PartyMemberStats: Equatable {}
