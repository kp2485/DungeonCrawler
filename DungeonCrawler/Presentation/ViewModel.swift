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

    // Store cancellables if we use Combine, or just poll in update
    private var cancellables = Set<AnyCancellable>()

    init(world: World) {
        self.world = world
        worldState = world.state
        self.partyStats = PartyStats(partyMembers: world.partyMembers)

        let displayLink = NSScreen.main?.displayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .current, forMode: .common)

        // Subscribe to World changes if we wanted, but we have a game loop anyway
    }

    @objc func update() {
        if worldState != world.state {
            worldState = world.state
        }

        let updatedStats = PartyStats(partyMembers: world.partyMembers)
        if updatedStats != partyStats {
            partyStats = updatedStats
        }

        // Update Combat State
        if isCombatActive != world.isCombatActive {
            isCombatActive = world.isCombatActive
        }

        // Ideally we only map this only when it changes, but for now every frame is fine for prototype
        if isCombatActive {
            let newQueue = world.turnQueue.map { "\($0.name) (Init: \($0.currentInitiative))" }
            if turnQueue != newQueue {
                turnQueue = newQueue
            }

            if let active = world.activeCombatant {
                if activeCombatantName != active.name {
                    activeCombatantName = active.name
                }

                if let pm = active as? PartyMember {
                    if activeAbilities != pm.abilities {
                        activeAbilities = pm.abilities
                    }
                } else if !activeAbilities.isEmpty {
                    activeAbilities = []
                }
            }
        } else {
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
