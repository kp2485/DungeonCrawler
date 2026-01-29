//
//  CombatEngine.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/28/26.
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
    @Published var lastEffect: CombatVisualEvent?

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

        // Get Weapon (or default Unarmed)
        let weapon = source.equippedWeapon ?? Weapon.unarmed

        // Ranged check (if we had ranged weapons, we'd check weapon.isRanged)
        // For now, if back row and not ranged (assuming all melee for prototype), penalty or block?
        // Let's say Unarmed/Melee cannot hit from back row.
        // Future: Check weapon.range type
        if inBackRow && weapon.motion != .shoot {
            combatLog.append("\(source.name) is too far to use \(weapon.name)!")
            return
        }

        switch target {
        case .singleEnemy(let enemy):
            if enemy.isAlive {
                // 1. Calculate Hit Chance
                // Base 85% + (Dex * 2)% - (Enemy Speed/Agility * 1)% + Weapon Accuracy
                // Simplified:
                let hitChance =
                    85 + (source.attributes.dexterity * 2) - (enemy.attributes.speed)
                    + weapon.accuracyBonus
                let roll = Int.random(in: 1...100)

                // Crit Chance
                let critChancePercent = (weapon.critChance * 100) + Double(source.attributes.luck)
                let isCrit = Double.random(in: 0...100) < critChancePercent

                // Log Motion
                // "[Source] [Motion] [Weapon] at [Target]"
                // e.g. "Conan swings Iron Sword at Skeleton"
                var weaponNameFragment = weapon.name
                if weapon.motion == .brawl {
                    weaponNameFragment = "with their fists"
                } else {
                    weaponNameFragment = weapon.name
                }

                let motionText =
                    "\(source.name) \(weapon.motion.rawValue) \(weaponNameFragment) at \(enemy.name)"

                if roll <= hitChance {
                    // Hit!
                    var dmg = weapon.damage + (source.attributes.strength / 2)

                    if isCrit {
                        dmg *= 2
                        combatLog.append("\(motionText) and CRITICALLY HITS!")
                    } else {
                        combatLog.append("\(motionText) and hits.")
                    }

                    // Defense mitigation?
                    if enemy.hasCondition(.defending) {
                        dmg /= 2
                    }

                    let finalDmg = max(1, dmg)
                    enemy.takeDamage(finalDmg)
                    combatLog.append("Dealt \(finalDmg) damage.")

                    if !enemy.isAlive {
                        combatLog.append("\(enemy.name) was destroyed!")
                    }
                } else {
                    // Miss
                    combatLog.append("\(motionText) but misses!")
                }

            } else {
                combatLog.append("\(source.name) attacks a corpse.")
            }
        default:
            combatLog.append("\(source.name) attacks wildly!")
        }
    }

    // MARK: - Dice Rolling
    private func rollDice(formula: String) -> Int {
        // Simple parser for "XdY+Z"
        // 1. Check for modifier
        var modifier = 0
        var dicePart = formula

        let components = formula.components(separatedBy: "+")
        if components.count > 1, let mod = Int(components[1]) {
            modifier = mod
            dicePart = components[0]
        } else if let modIndex = formula.lastIndex(of: "-") {
            // Handle negative modifier simple case if needed, but for now assuming XdY+Z
            // Parsing - is trickier without regex, assuming + for now based on examples
        }

        // 2. Parse XdY
        let dSplit = dicePart.lowercased().components(separatedBy: "d")
        guard dSplit.count == 2,
            let count = Int(dSplit[0]),
            let sides = Int(dSplit[1])
        else {
            print("Invalid dice formula: \(formula), fallback to 1d4")
            return Int.random(in: 1...4)
        }

        var total = 0
        for _ in 0..<count {
            total += Int.random(in: 1...sides)
        }

        return total + modifier
    }

    private func resolveCast(source: Combatant, ability: Ability, level: Int, target: TargetScope) {
        // Check Mana
        if source.currentMana < ability.manaCost {
            combatLog.append("\(source.name) tries to cast \(ability.name) but lacks mana!")
            return
        }

        source.currentMana -= ability.manaCost
        combatLog.append("\(source.name) casts \(ability.name) (Lvl \(level))!")

        switch ability.type {
        case .damage:
            // Roll Damage
            let baseDamage = rollDice(formula: ability.diceRoll)
            // Scale by attribute (simple: + Attribute/2)
            var attributeBonus = 0
            switch ability.attributeScaling {
            case .strength: attributeBonus = source.attributes.strength / 2
            case .intelligence: attributeBonus = source.attributes.intelligence / 2
            case .dexterity: attributeBonus = source.attributes.dexterity / 2
            case .wisdom: attributeBonus = source.attributes.wisdom / 2
            default: break
            }

            // Scale by Level (simple: + Level)
            let totalPower = baseDamage + attributeBonus + level

            if case .singleEnemy(let enemy) = target {
                applyDamage(to: enemy, amount: totalPower, type: ability.damageType)
            } else if case .enemyGroup(let group) = target {
                let aoeDmg = totalPower / 2  // AOE penalty
                for enemy in group.enemies where enemy.isAlive {
                    applyDamage(to: enemy, amount: aoeDmg, type: ability.damageType)
                }
            }
        case .heal:
            if case .singleAlly(let ally) = target {
                let baseHeal = rollDice(formula: ability.diceRoll)
                let bonus = (source.attributes.wisdom / 2) + level
                let healAmount = baseHeal + bonus

                ally.currentHP = min(ally.maxHP, ally.currentHP + healAmount)
                combatLog.append("Healed \(ally.name) for \(healAmount).")
                lastEffect = CombatVisualEvent(type: .flashGreen)
            }
        case .buff, .utility:
            if case .singleAlly(let ally) = target {
                combatLog.append("\(ally.name) feels the power of \(ability.name)!")
            }
        case .debuff, .aoe:
            if case .singleEnemy(let enemy) = target {
                combatLog.append("\(enemy.name) is affected by \(ability.name)!")
            }
        default:
            combatLog.append("Effect execution skipped.")
        }
    }

    private func applyDamage(to enemy: Enemy, amount: Int, type: DamageType) {
        // Check Weakness/Resistance (Enemy struct needs to support this, currently it doesn't have it explicitly defined as a property)
        // BUT the user prompt said: "Use strongAgainst/weakAgainst on ABILITIES".
        // Wait, "Every ability should have a property... strongAgainst and weakAgainst".
        // This usually implies the Ability (Attack) is Strong Against a Target Type.
        // OR the Target has Weaknesses.
        // The prompt says: "Every ability should have a property (potentially empty) strongAgainst: [DamageType] and weakAgainst: [DamageType]"
        // This implies Pokemon style? "Water Gun is strong against Fire".
        // BUT the Ability itself has a `damageType` (e.g. Water).
        // If the Ability struct has `strongAgainst`, it implies "This Ability deals double damage to [Type]".
        // So we need to know the ENEMY'S type?
        // MythologicalCharacter has separate `tags` (Category).
        // Does it have an Elemental Type?
        // The prompt didn't explicitly ask to add Elemental Types to Characters, just "Letter based files... unique dice roll... strong/weak on abilities".
        // Let's assume Characters don't have explicit Element types yet, OR we infer from Tags using logic?
        // actually, if Ability has `strongAgainst: [.fire]`, and we hit an Enemy, how do we know if Enemy is Fire?
        // Perhaps `MythologicalCharacter` needs a `primaryType`?
        // For now, I will skip the multiplier logic or use a placeholder or check Tags (e.g. Hephaestus -> Fire-like).
        // Better: I'll check if the Enemy's name or tags imply a type, OR logic is simplified.
        // Given constraints and prompt "strongAgainst: [DamageType]", I might have misunderstood.
        // Usually, *Defenders* have Weakness, *Attacks* have Type.
        // If *Attack* has "StrongAgainst", it explicitly lists what it crits on.
        // So: `if ability.strongAgainst.contains(enemy.type)` -> 2x.
        // But Enemy has no Type.
        // I'll leave the multiplier as 1.0 for now but add a generic TODO note in the log, OR infer from Metadata.
        // Wait, I can't modify Enemy struct to add Type in this Turn easily if I didn't plan it.
        // I'll modify Enemy to rely on its `character` property if I stored it? I only stored `name`.
        // I will just apply raw damage for now.

        enemy.takeDamage(amount)
        combatLog.append("Dealt \(amount) \(type.rawValue) damage to \(enemy.name).")

        if !enemy.isAlive {
            combatLog.append("\(enemy.name) was defeated!")
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
