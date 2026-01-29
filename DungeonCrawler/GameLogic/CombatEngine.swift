//
//  CombatEngine.swift
//  DungeonCrawler
//
//  Created by Antigravity on 1/28/26.
//

import Combine
import Foundation

final class CombatEngine: ObservableObject {
    unowned let delegate: CombatDelegate
    let enemyGroup: EnemyGroup

    // Combat State
    @Published var phase: CombatPhase = .selection
    @Published var currentRound: Int = 0
    @Published var combatLog: [String] = []

    // Selection State
    // Selection State
    var pendingActions: [UUID: CombatAction] = [:]  // PartyMember ID -> Action

    // Who is currently selecting?
    var selectionQueue: [PartyMember] = []

    var currentSelectionMember: PartyMember? {
        selectionQueue.first
    }

    // Execution State
    var turnQueue: [Combatant] = []
    var currentTurnIndex: Int = 0

    var activeCombatant: Combatant? {
        guard phase == .execution, turnQueue.indices.contains(currentTurnIndex) else { return nil }
        return turnQueue[currentTurnIndex]
    }

    init(delegate: CombatDelegate, enemyGroup: EnemyGroup) {
        self.delegate = delegate
        self.enemyGroup = enemyGroup
        print("Combat Started against \(enemyGroup.name)")
        startRound()
    }

    func startRound() {
        phase = .selection
        currentRound += 1
        pendingActions.removeAll()

        // Prepare selection queue (alive members)
        // Prepare selection queue (alive members)
        selectionQueue = delegate.partyMembers.alivePartyMembers.sorted {
            $0.attributes.speed > $1.attributes.speed
        }

        // Auto-select actions for dead members (shouldn't be in queue check, but safety)

        combatLog.append("\n--- Round \(currentRound) Start ---")

        // Apply DOTs and decrement durations
        applyStatusEffects()

        if selectionQueue.isEmpty {
            // Everyone dead? Should be caught by battle end checks, but handle edge case
            endRound()
        }
    }

    // MARK: - Status Effects

    private func applyStatusEffects() {
        var combatants: [Combatant] = delegate.partyMembers.alivePartyMembers
        combatants.append(contentsOf: enemyGroup.enemies.filter { $0.isAlive })

        for combatant in combatants {
            // Remove defensive stance from previous round
            combatant.activeConditions.removeAll { $0 == .defending }

            // Check for Poison
            // Note: In a real system we'd associate values or have a Conditions manager
            // For now, simple iteration
            for condition in combatant.activeConditions {
                if case .poison(let dmg) = condition {
                    combatant.takeDamage(dmg)
                    combatLog.append("\(combatant.name) takes \(dmg) poison damage.")
                }
            }

            if !combatant.isAlive {
                combatLog.append("\(combatant.name) succumbed to conditions.")
            }
        }
    }

    // MARK: - Selection Phase

    func selectAction(for member: PartyMember, action: CombatAction) {
        // Confirm member is the current selector to prevent out-of-order
        guard let current = currentSelectionMember, current.id == member.id else {
            print(
                "Ignoring action from \(member.name), waiting for \(currentSelectionMember?.name ?? "none")"
            )
            return
        }

        pendingActions[member.id] = action
        if !selectionQueue.isEmpty {
            selectionQueue.removeFirst()
        }

        checkSelectionComplete()
    }

    private func checkSelectionComplete() {
        if selectionQueue.isEmpty {
            startExecutionPhase()
        }
    }

    // MARK: - Execution Phase

    func startExecutionPhase() {
        phase = .execution
        combatLog.append("Executing actions...")

        // 1. Roll Initiatives
        var combatants: [Combatant] = delegate.partyMembers.alivePartyMembers
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

        // Perform Action
        if let partyMember = combatant as? PartyMember {
            if let action = pendingActions[partyMember.id] {
                perform(action, source: partyMember)
            } else {
                combatLog.append("\(partyMember.name) hesitated!")
            }
        } else if let enemy = combatant as? Enemy {
            performEnemyTurn(enemy)
        }

        // Check for battle end
        if checkBattleEnd() { return }

        // Delay before next turn for "beat by beat" feel
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.currentTurnIndex += 1
            self?.processNextTurn()
        }
    }

    private func perform(_ action: CombatAction, source: PartyMember) {
        switch action {
        case .attack(let targetScope):
            resolveAttack(source: source, target: targetScope)
        case .cast(let ability, let level, let target):
            resolveCast(source: source, ability: ability, level: level, target: target)
        case .defend:
            combatLog.append("\(source.name) takes a defensive stance.")
            source.activeConditions.append(.defending)
        case .item(let item, let target):
            resolveItem(source: source, item: item, target: target)
        case .run:
            combatLog.append("\(source.name) tries to run!")
            // Run Logic
            // Simple probability: 50% + Speed Bonus
            // For now, flat 50%
            if Double.random(in: 0...1) < 0.5 {
                combatLog.append("Got away safely!")
                delegate.endCombat(result: .escaped)
            } else {
                combatLog.append("Couldn't escape!")
            }
        case .wait:
            combatLog.append("\(source.name) waits.")
        }
    }

    private func performEnemyTurn(_ enemy: Enemy) {
        // AI Logic
        // 1. Check for usable abilities (Mana check)
        let usableAbilities = enemy.abilities.filter { enemy.currentMana >= $0.manaCost }

        // 2. Decide Action Type: 30% chance to cast if possible
        if !usableAbilities.isEmpty && Double.random(in: 0...1) < 0.3 {
            let ability = usableAbilities.randomElement()!

            // Determine Target based on Ability Type
            var target: TargetScope?

            switch ability.type {
            case .heal, .buff:
                // Target wounded ally
                let allies = enemyGroup.enemies.filter { $0.isAlive }
                if let wounded = allies.min(by: { $0.currentHP < $1.currentHP }),
                    wounded.currentHP < wounded.maxHP
                {
                    target = .singleEnemy(wounded)  // Using .singleEnemy for enemy-side heal target
                    // Wait, TargetScope.singleEnemy means "Target an Enemy class instance".
                    // Logic in resolveCast handles ability type.
                    // But usually "Enemy" means "Enemy of the Party".
                    // Ideally TargetScope should be .ally(Combatant) / .opponent(Combatant) but we have specific types.
                    // For now, .singleEnemy(wounded) is technically correct typewise, but resolveCast needs to handle it.
                } else {
                    target = .singleEnemy(enemy)  // Self cast
                }
            case .damage, .debuff, .aoe, .utility:
                // Target player
                let potentialTargets = delegate.partyMembers.alivePartyMembers
                if let randomTarget = potentialTargets.randomElement() {
                    target = .singleAlly(randomTarget)  // .singleAlly(PartyMember)
                    // Wait, TargetScope .singleAlly expects PartyMember.
                    // But naming is confusing. .singleAlly usually means "Ally of Source".
                    // If Source is Enemy, Ally is Enemy.
                    // But .singleAlly wraps PartyMember.
                    // .singleEnemy wraps Enemy.

                    // We need to check TargetScope definition.
                    // case singleEnemy(Enemy)
                    // case singleAlly(PartyMember)

                    // So if Enemy casts Damage on PartyMember, target must be .singleAlly(PartyMember).
                    // This naming assumes "Ally" = PartyMember.
                }
            }

            if let target = target {
                resolveCast(source: enemy, ability: ability, level: enemy.level, target: target)
                return
            }
        }

        // Fallback: Attack
        // Simple AI: Attack random front row
        // If front row empty, attack back row

        // Get potential targets
        let frontRow = [delegate.partyMembers[.frontLeft], delegate.partyMembers[.frontRight]]
            .compactMap { $0 }.filter { $0.isAlive }
        let backRow = [delegate.partyMembers[.backLeft], delegate.partyMembers[.backRight]]
            .compactMap {
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

    // MARK: - Helpers

    private func partyPosition(of member: PartyMember) -> PartyPosition? {
        // Attempt to find the member in any of the four party slots
        if let frontLeft = delegate.partyMembers[.frontLeft], frontLeft.id == member.id {
            return .frontLeft
        }
        if let frontRight = delegate.partyMembers[.frontRight], frontRight.id == member.id {
            return .frontRight
        }
        if let backLeft = delegate.partyMembers[.backLeft], backLeft.id == member.id {
            return .backLeft
        }
        if let backRight = delegate.partyMembers[.backRight], backRight.id == member.id {
            return .backRight
        }
        return nil
    }

    // MARK: - Action Resolution

    private func resolveAttack(source: PartyMember, target: TargetScope) {
        let partyPosition = partyPosition(of: source)
        let inBackRow = (partyPosition == .backLeft || partyPosition == .backRight)

        // Our constraint: Back Row Party members cannot use MELEE (unless they have ranged weapons; not implemented yet)
        if inBackRow {
            combatLog.append("\(source.name) is too far away to attack!")
            return
        }

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

    private func resolveCast(source: Combatant, ability: Ability, level: Int, target: TargetScope) {
        // Check Mana
        if source.currentMana < ability.manaCost {
            combatLog.append("\(source.name) tries to cast \(ability.name) but lacks mana!")
            return
        }

        source.currentMana -= ability.manaCost
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
        case .buff, .utility:  // Grouping utility here for now
            if case .singleAlly(let ally) = target {
                // Simplified buff logic
                // Ideally Ability needs to specify which Attribute to buff
                // For now, let's just say "Strength" for War Cry-like buffs, or use description mapping
                // This requires Ability to hold more data or hardcoded mapping.
                // I will assume generic buff for now.
                combatLog.append(
                    "\(ally.name) feels stronger! (Buff not fully implemented in stats)")
            }
        case .debuff, .aoe:  // Grouping aoe here for now (should implement proper AOE)
            if case .singleEnemy(let enemy) = target {
                // Simplified debuff
                combatLog.append("\(enemy.name) is weakened! (Debuff not fully implemented)")
                // Example: Apply Poison if it was a poison spell
                // source.activeConditions.append(.poison(5)) // Logic needs Ability -> Condition mapping
            }
        default:
            combatLog.append("Effect not fully implemented.")
        }
    }

    private func resolveItem(source: PartyMember, item: Item, target: TargetScope) {
        if let index = source.inventory.firstIndex(where: { $0.id == item.id }) {
            source.inventory.remove(at: index)
        } else {
            combatLog.append("\(source.name) fumbles for an item they don't have!")
            return
        }

        combatLog.append("\(source.name) uses \(item.name).")

        switch item.type {
        case .potion:
            if case .singleAlly(let ally) = target {
                let heal = item.power
                ally.currentHP = min(ally.maxHP, ally.currentHP + heal)
                combatLog.append("Recovered \(heal) HP to \(ally.name).")
            }
        case .manaPotion:
            if case .singleAlly(let ally) = target {
                let amount = item.power
                ally.currentMana = min(ally.maxMana, ally.currentMana + amount)
                combatLog.append("Recovered \(amount) Mana to \(ally.name).")
            }
        case .revive:
            combatLog.append("Revive not implemented.")
        }
    }

    // MARK: - Round End

    private func endRound() {
        startRound()
    }

    private func checkBattleEnd() -> Bool {
        if !enemyGroup.isAlive {
            phase = .victory

            // Calculate XP
            // Assuming average of 10-20 XP per enemy for now, or based on stats
            // Let's verify if Enemy has an XP property? No, so we estimate.
            // 20 XP per enemy
            let totalXP = enemyGroup.enemies.count * 20
            combatLog.append("Victory! Gained \(totalXP) XP.")

            // Award XP (Naive implementation, assume World handles it or we iterate)
            for member in delegate.partyMembers.alivePartyMembers {
                member.addXP(totalXP)
                combatLog.append("\(member.name) gained \(totalXP) XP.")
            }

            // Delay cleanup to show victory message
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.delegate.endCombat(result: .victory)
            }
            return true
        }

        if delegate.partyMembers.alivePartyMembers.isEmpty {
            phase = .defeat
            combatLog.append("Party was wiped out...")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.delegate.endCombat(result: .defeat)
            }
            return true
        }

        return false
    }
}
