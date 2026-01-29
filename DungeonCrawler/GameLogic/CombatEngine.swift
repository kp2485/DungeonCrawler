//
//  CombatEngine.swift
//  DungeonCrawler
//
//  Created by Antigravity on 1/28/26.
//

import Combine
import Foundation

final class CombatEngine: ObservableObject {
    unowned let world: World
    private let enemyGroup: EnemyGroup

    // Combat State
    @Published var phase: CombatPhase = .selection
    @Published var currentRound: Int = 1
    @Published var combatLog: [String] = []

    // Selection State
    var pendingActions: [UUID: CombatAction] = [:]  // PartyMember ID -> Action

    // Execution State
    var turnQueue: [Combatant] = []
    var currentTurnIndex: Int = 0

    var activeCombatant: Combatant? {
        guard phase == .execution, turnQueue.indices.contains(currentTurnIndex) else { return nil }
        return turnQueue[currentTurnIndex]
    }

    init(world: World, enemyGroup: EnemyGroup) {
        self.world = world
        self.enemyGroup = enemyGroup
        print("Combat Started against \(enemyGroup.name)")
    }

    // MARK: - Selection Phase

    func selectAction(for member: PartyMember, action: CombatAction) {
        // In a real app we'd use ID, but for now object identity or name
        // Assuming PartyMember has ID or we rely on the instance
        // For this prototype, I'll store by Name if ID isn't available easily, strict mode says Member object
        // Let's assume we can map Member -> Action.
        // We'll use a simple dictionary with ObjectIdentifier or add ID to PartyMember later.
        // For now, let's just assume we process them in order or store in a local dict by name.
        pendingActions[member.id] = action

        checkSelectionComplete()
    }

    private func checkSelectionComplete() {
        let aliveMembers = world.partyMembers.alivePartyMembers
        let selectedCount = pendingActions.count

        // If all alive members have selected an action
        // In reality, we probably want a "Confirm" button, but for auto-flow:
        if selectedCount >= aliveMembers.count {
            startExecutionPhase()
        }
    }

    // MARK: - Execution Phase

    func startExecutionPhase() {
        phase = .execution
        combatLog.append("--- Round \(currentRound) ---")

        // 1. Roll Initiatives
        var combatants: [Combatant] = world.partyMembers.alivePartyMembers
        combatants.append(contentsOf: enemyGroup.enemies.filter { $0.isAlive })

        for combatant in combatants {
            combatant.rollInitiative()
        }

        // 2. Sort by speed/initiative
        turnQueue = combatants.sorted {
            if $0.currentInitiative == $1.currentInitiative {
                return $0.attributes.speed > $1.attributes.speed
            }
            return $0.currentInitiative > $1.currentInitiative
        }

        currentTurnIndex = 0
        processNextTurn()
    }

    private func processNextTurn() {
        guard currentTurnIndex < turnQueue.count else {
            endRound()
            return
        }

        let combatant = turnQueue[currentTurnIndex]

        if !combatant.isAlive {
            currentTurnIndex += 1
            processNextTurn()
            return
        }

        if let partyMember = combatant as? PartyMember {
            if let action = pendingActions[partyMember.id] {
                perform(action, source: partyMember)
            } else {
                combatLog.append("\(partyMember.name) hesitated!")
            }
        } else if let enemy = combatant as? Enemy {
            performEnemyTurn(enemy)
        }

        // Check for battle end after every action
        if checkBattleEnd() { return }

        // Small delay for UI or just continue
        // In a real game loop we'd wait, here we just recurse effectively instantaneous
        currentTurnIndex += 1
        processNextTurn()
    }

    private func perform(_ action: CombatAction, source: PartyMember) {
        switch action {
        case .attack(let targetScope):
            resolveAttack(source: source, target: targetScope)
        case .cast(let ability, let level, let target):
            resolveCast(source: source, ability: ability, level: level, target: target)
        case .defend:
            combatLog.append("\(source.name) defends.")
        // Logic for defense buff
        case .item:
            combatLog.append("\(source.name) uses an item (Not Implemented).")
        case .run:
            combatLog.append("\(source.name) tries to run!")
        // Run logic
        case .wait:
            combatLog.append("\(source.name) waits.")
        }
    }

    private func performEnemyTurn(_ enemy: Enemy) {
        // Simple AI: Attack random front row
        // If front row empty, attack back row

        // Get potential targets
        let frontRow = [world.partyMembers[.frontLeft], world.partyMembers[.frontRight]].compactMap
        { $0 }.filter { $0.isAlive }
        let backRow = [world.partyMembers[.backLeft], world.partyMembers[.backRight]].compactMap {
            $0
        }.filter { $0.isAlive }

        let targets = !frontRow.isEmpty ? frontRow : backRow

        if let target = targets.randomElement() {
            combatLog.append("\(enemy.name) attacks \(target.name)!")
            // DMG calc
            let dmg = max(1, (enemy.attributes.strength / 2) - (target.attributes.endurance / 4))
            target.takeDamage(dmg)
            combatLog.append("Dealt \(dmg) damage.")

            if !target.isAlive {
                combatLog.append("\(target.name) collapsed!")
            }
        } else {
            combatLog.append("\(enemy.name) glares menacingly.")
        }
    }

    // MARK: - Action Resolution

    private func resolveAttack(source: PartyMember, target: TargetScope) {
        // Verify Target Accessibility (Rank Check)
        // For now, assume Selection UI filtered invalid targets

        switch target {
        case .singleEnemy(let enemy):
            if enemy.isAlive {
                combatLog.append("\(source.name) attacks \(enemy.name)!")
                let dmg = max(
                    1, (source.attributes.strength / 2) - (enemy.attributes.endurance / 4))
                enemy.takeDamage(dmg)
                combatLog.append("Hit for \(dmg) damage.")
                if !enemy.isAlive {
                    combatLog.append("\(enemy.name) was destroyed!")
                }
            } else {
                combatLog.append("\(source.name) attacks a corpse.")
            }
        default:
            combatLog.append("\(source.name) attacks wildly!")
        }
    }

    private func resolveCast(source: PartyMember, ability: Ability, level: Int, target: TargetScope)
    {
        combatLog.append("\(source.name) casts \(ability.name) (Lvl \(level))!")
        // Apply mana cost, scaling etc.
        // For prototype, simple damage

        switch ability.type {
        case .damage:
            if case .singleEnemy(let enemy) = target {
                let dmg = ability.power * level + (source.attributes.intelligence / 2)
                enemy.takeDamage(dmg)
                combatLog.append("Blasted \(enemy.name) for \(dmg)!")
            } else if case .enemyGroup(let group) = target {
                let dmg = (ability.power * level) / 2  // AOE less dmg
                for enemy in group.enemies where enemy.isAlive {
                    enemy.takeDamage(dmg)
                    combatLog.append("Hit \(enemy.name) for \(dmg).")
                }
            }
        case .heal:
            if case .singleAlly(let ally) = target {
                let heal = ability.power * level
                ally.currentHP = min(ally.maxHP, ally.currentHP + heal)
                combatLog.append("Healed \(ally.name) for \(heal).")
            }
        default:
            combatLog.append("Effect not implemented.")
        }
    }

    // MARK: - Round End

    private func endRound() {
        pendingActions.removeAll()
        currentRound += 1
        phase = .selection
        combatLog.append("Round completed. Select actions.")
    }

    private func checkBattleEnd() -> Bool {
        if !enemyGroup.isAlive {
            phase = .victory
            combatLog.append("Victory! Gained 0 XP (TODO).")
            return true
        }

        if world.partyMembers.alivePartyMembers.isEmpty {
            phase = .defeat
            combatLog.append("Party was wiped out...")
            return true
        }

        return false
    }
}
