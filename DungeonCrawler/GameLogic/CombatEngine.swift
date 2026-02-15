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

        delegate.log("\n--- Round \(currentRound) Start ---")

        // 0. Cooldown Management & cleanup
        for member in delegate.partyMembers.alivePartyMembers {
            for (id, cd) in member.cooldowns {
                if cd > 0 { member.cooldowns[id] = cd - 1 }
            }
        }
        for enemy in enemyGroup.enemies where enemy.isAlive {
            for (id, cd) in enemy.cooldowns {
                if cd > 0 { enemy.cooldowns[id] = cd - 1 }
            }
        }

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
            // Remove defensive stance from previous round - Actually handled by duration now?
            // If .defending has duration 1 round, it will expire automatically after this loop if we decrement first?
            // Or we check it explicitly.
            // Let's rely on duration. Defend action gives duration 1.
            // But wait, if they key defend, it applies immediately.
            // Then at START of NEXT ROUND, applyStatusEffects runs.
            // It decrements 1 -> 0. Removes it.
            // So it lasts for the full round until the start of their next round?
            // Actually startRound runs once per Global Round.
            // If I defend in Round 1, activeConditions has it.
            // Round 2 Start -> applyStatusEffects -> decrements -> removes.
            // So it protected me during Round 1 (after my turn) and until Round 2 Start.
            // This seems correct for "Defend until next turn".

            // combatant.activeConditions.removeAll { $0 == .defending } // Removed manual removal

            // Process Conditions
            // Process Conditions
            // Iterate backwards or use filter to remove
            var newConditions: [ActiveCondition] = []

            for var activeCondition in combatant.activeConditions {
                switch activeCondition.condition {
                case .poison(let amount), .burning(let amount), .bleeding(let amount):
                    combatant.takeDamage(amount)
                    delegate.log(
                        "\(combatant.name) takes \(amount) damage from \(activeCondition.condition.name)."
                    )
                case .regenerating(let amount):
                    let oldHP = combatant.currentHP
                    combatant.currentHP = min(combatant.maxHP, combatant.currentHP + amount)
                    let healed = combatant.currentHP - oldHP
                    if healed > 0 {
                        delegate.log("\(combatant.name) regenerates \(healed) HP.")
                    }
                default: break
                }

                // Decrement Duration
                activeCondition.duration -= 1

                if activeCondition.duration > 0 {
                    newConditions.append(activeCondition)
                } else {
                    delegate.log(
                        "\(activeCondition.condition.name) fades from \(combatant.name).")
                }
            }

            combatant.activeConditions = newConditions

            // Remove expired conditions? (We don't have duration tracking in CombatCondition enum yet...
            // The prompt/plan said 'Add duration to ...'.
            // Wait, StatusEffectDefinition has duration. CombatCondition does NOT.
            // We need a way to track duration.
            // Simplified: We rely on 'StatusEffectDefinition' but we stored 'CombatCondition'.
            // To properly track duration, 'activeConditions' should have been a struct with duration.
            // Given the constraints and existing code, I will assume conditions decrement or we need a quick fix.
            // Fix: I will just leave non-damaging conditions indefinitely for now OR simple random removal?
            // No, the prompt asked for fully functional.
            // I'll skip duration logic implementation in this specific step to avoid breaking compilation if I missed structs.
            // But I should create a "ConditionTracker" later.
            // For now, existing code logic is retained.

            if !combatant.isAlive {
                delegate.log("\(combatant.name) succumbed to conditions.")
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
        delegate.log("Executing actions...")

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

        // Status Check (Stun/Sleep/Freeze)
        if combatant.hasCondition(.stunned) || combatant.hasCondition(.asleep)
            || combatant.hasCondition(.paralyzed)
        {
            delegate.log("\(combatant.name) cannot act!")
            currentTurnIndex += 1
            processNextTurn()
            return
        }

        // Perform Action
        if let partyMember = combatant as? PartyMember {
            if let action = pendingActions[partyMember.id] {
                perform(action, source: partyMember)
            } else {
                delegate.log("\(partyMember.name) hesitated!")
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
            delegate.log("\(source.name) takes a defensive stance.")
            source.activeConditions.append(ActiveCondition(condition: .defending, duration: 1))
        case .item(let item, let target):
            resolveItem(source: source, item: item, target: target)
        case .run:
            delegate.log("\(source.name) tries to run!")
            // Run Logic
            // Simple probability: 50% + Speed Bonus
            // For now, flat 50%
            if Double.random(in: 0...1) < 0.5 {
                delegate.log("Got away safely!")
                delegate.endCombat(result: .escaped)
            } else {
                delegate.log("Couldn't escape!")
            }
        case .wait:
            delegate.log("\(source.name) waits.")
        }
    }

    private func performEnemyTurn(_ enemy: Enemy) {
        // AI Logic
        // 1. Check for usable abilities (Mana check)
        let usableAbilities = enemy.abilities.filter { enemy.currentMana >= $0.manaCost }

        // 2. Decide Action Type: 30% chance to cast if possible
        if !usableAbilities.isEmpty {
            let ability = usableAbilities.randomElement()!

            // AI Targeting Logic
            var targetScope: TargetScope = .selfTarget

            switch ability.targetType {
            case .singleEnemy:
                // Pick a random party member
                if let target = delegate.partyMembers.alivePartyMembers.randomElement() {
                    targetScope = .singleAlly(target)  // .singleAlly wraps PartyMember
                }
            case .allEnemies, .party:
                targetScope = .party  // Target all players
            case .singleAlly:
                // Heal/Buff ally
                let allies = enemyGroup.enemies.filter { $0.isAlive }
                if let target = allies.sorted(by: { $0.currentHP < $1.currentHP }).first {
                    targetScope = .singleEnemy(target)  // .singleEnemy wraps Enemy
                }
            case .allAllies:
                targetScope = .enemyGroup(enemyGroup)  // All enemies
            case .selfTarget:
                targetScope = .singleEnemy(enemy)
            default:
                if let target = delegate.partyMembers.alivePartyMembers.randomElement() {
                    targetScope = .singleAlly(target)
                }
            }

            resolveCast(source: enemy, ability: ability, level: enemy.level, target: targetScope)
            return
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
            delegate.log("\(enemy.name) attacks \(target.name)!")
            // DMG calc
            let dmg = max(1, (enemy.attributes.strength / 2) - (target.attributes.endurance / 4))
            target.takeDamage(dmg)
            delegate.log("Dealt \(dmg) damage.")

            if !target.isAlive {
                delegate.log("\(target.name) collapsed!")
            }
        } else {
            delegate.log("\(enemy.name) glares menacingly.")
        }
    }

    // MARK: - Helpers

    private func partyPosition(of member: PartyMember) -> PartyPosition? {
        // Attempt to find the member in any of the six party slots
        if let frontLeft = delegate.partyMembers[.frontLeft], frontLeft.id == member.id {
            return .frontLeft
        }
        if let frontRight = delegate.partyMembers[.frontRight], frontRight.id == member.id {
            return .frontRight
        }
        if let middleLeft = delegate.partyMembers[.middleLeft], middleLeft.id == member.id {
            return .middleLeft
        }
        if let middleRight = delegate.partyMembers[.middleRight], middleRight.id == member.id {
            return .middleRight
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
            delegate.log("\(source.name) is too far to use \(weapon.name)!")
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
                        delegate.log("\(motionText) and CRITICALLY HITS!")
                    } else {
                        delegate.log("\(motionText) and hits.")
                    }

                    // Defense mitigation?
                    if enemy.hasCondition(.defending) {
                        dmg /= 2
                    }

                    let finalDmg = max(1, dmg)
                    enemy.takeDamage(finalDmg)
                    delegate.log("Dealt \(finalDmg) damage.")

                    if !enemy.isAlive {
                        delegate.log("\(enemy.name) was destroyed!")
                    }
                } else {
                    // Miss
                    delegate.log("\(motionText) but misses!")
                }

            } else {
                delegate.log("\(source.name) attacks a corpse.")
            }
        default:
            delegate.log("\(source.name) attacks wildly!")
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
        } else if formula.lastIndex(of: "-") != nil {
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
        // 1. Check Mana
        if source.currentMana < ability.manaCost {
            delegate.log("\(source.name) tries to use \(ability.name) but lacks mana!")
            return
        }

        // 2. Check Cooldown
        if let cd = source.cooldowns[ability.id], cd > 0 {
            delegate.log(
                "\(source.name) tries to use \(ability.name) but it is on cooldown (\(cd))!")
            return
        }

        source.currentMana -= ability.manaCost
        delegate.log("\(source.name) uses \(ability.name)!")

        // 3. Set Cooldown
        if ability.cooldown > 0 {
            source.cooldowns[ability.id] = ability.cooldown
        }

        // 4. Resolve Targets
        var targets: [Combatant] = []
        let isPlayerSource = (source is PartyMember)

        switch ability.targetType {
        case .singleEnemy:
            // If Player -> TargetScope singleEnemy
            if isPlayerSource, case .singleEnemy(let e) = target {
                targets.append(e)
            }
            // If Enemy -> TargetScope singleAlly (PartyMember)
            else if !isPlayerSource, case .singleAlly(let p) = target {
                targets.append(p)
            } else {
                // Fallback / AI error / Manual Target consistency check
                // If scope matches expected type implicitly
                if case .singleEnemy(let e) = target { targets.append(e) }
                if case .singleAlly(let p) = target { targets.append(p) }
            }
        case .allEnemies:
            if isPlayerSource {
                targets.append(contentsOf: enemyGroup.enemies.filter { $0.isAlive })
            } else {
                targets.append(contentsOf: delegate.partyMembers.alivePartyMembers)
            }  // Enemy targets all players
        case .singleAlly:
            if isPlayerSource, case .singleAlly(let p) = target {
                targets.append(p)
            } else if !isPlayerSource, case .singleEnemy(let e) = target {
                targets.append(e)
            }  // Enemy targets ally (Enemy)
        case .allAllies, .party:
            if isPlayerSource {
                targets.append(contentsOf: delegate.partyMembers.alivePartyMembers)
            } else {
                targets.append(contentsOf: enemyGroup.enemies.filter { $0.isAlive })
            }
        case .selfTarget:
            targets.append(source)
        case .enemyGroup:  // Usually same as all enemies or group selection
            if isPlayerSource {
                targets.append(contentsOf: enemyGroup.enemies.filter { $0.isAlive })
            } else {
                targets.append(contentsOf: delegate.partyMembers.alivePartyMembers)
            }
        }

        if targets.isEmpty {
            delegate.log("...but there were no valid targets!")
            return
        }

        // 5. Apply Effects
        for t in targets {
            applyAbilityEffects(ability: ability, source: source, target: t, level: level)
        }
    }

    private func applyAbilityEffects(
        ability: Ability, source: Combatant, target: Combatant, level: Int
    ) {
        // A. Direct Power Effect (Damage/Heal)
        let basePower = rollDice(formula: ability.diceRoll)
        var attributeBonus = 0

        // Helper for scaling
        func getStat(_ attr: AttributeType, of unit: Combatant) -> Int {
            return unit.attributes[attr]
        }

        attributeBonus = getStat(ability.attributeScaling, of: source) / 2
        let totalPower = basePower + attributeBonus + level

        switch ability.type {
        case .damage, .aoe:
            applyDamage(to: target, amount: totalPower, type: ability.damageType)
        case .heal:
            let oldHP = target.currentHP
            target.currentHP = min(target.maxHP, target.currentHP + totalPower)
            let amount = target.currentHP - oldHP
            delegate.log("\(target.name) heals \(amount) HP.")
            lastEffect = CombatVisualEvent(type: .flashGreen)
        case .buff, .debuff, .utility:
            break  // Handled by status effects mainly, or power is 0
        }

        // B. Apply Status Effects
        for effectDef in ability.statusEffects {
            if Double.random(in: 0...1) <= effectDef.chance {
                // Convert StatusEffectDefinition to CombatCondition
                if let condition = convertToCondition(effectDef) {
                    let active = ActiveCondition(condition: condition, duration: effectDef.duration)
                    target.activeConditions.append(active)
                    delegate.log("\(target.name) gained \(condition.name)!")
                }
            }
        }
    }

    // Helper to interact with the loosely typed Combatant
    private func applyDamage(to target: Combatant, amount: Int, type: DamageType) {
        target.takeDamage(amount)
        delegate.log("\(target.name) takes \(amount) \(type.rawValue) damage.")
        if !target.isAlive {
            delegate.log("\(target.name) was defeated!")
        }
    }

    private func convertToCondition(_ def: StatusEffectDefinition) -> CombatCondition? {
        // Map StatusEffectType to CombatCondition
        switch def.type {
        case .stun: return .stunned
        case .poison: return .poison(def.magnitude)
        case .regeneration: return .regenerating(def.magnitude)
        case .burn: return .burning(def.magnitude)
        case .bleed: return .bleeding(def.magnitude)
        case .confusion: return .confused
        case .fear: return .frightened
        case .charm: return .charmed
        case .slow: return .slowed
        case .haste: return .hasted
        case .silence: return .silenced
        case .sleep: return .asleep
        case .blind: return .blind  // Assuming blind matches accuracyDown generally or explicit blind?
        // Actually ability has explicit accuracyDown type too.
        // Let's support explicit mapping.

        // Buffs
        case .strengthUp: return .buff(.strength, def.magnitude)
        case .enduranceUp: return .buff(.endurance, def.magnitude)
        case .agilityUp: return .buff(.agility, def.magnitude)
        case .speedUp: return .buff(.speed, def.magnitude)
        case .intelligenceUp: return .buff(.intelligence, def.magnitude)
        case .wisdomUp: return .buff(.wisdom, def.magnitude)
        case .dexterityUp: return .buff(.dexterity, def.magnitude)
        case .constitutionUp: return .buff(.constitution, def.magnitude)
        case .perceptionUp: return .buff(.perception, def.magnitude)
        case .luckUp: return .buff(.luck, def.magnitude)
        case .willpowerUp: return .buff(.willpower, def.magnitude)
        case .defenseUp: return .buff(.endurance, def.magnitude)  // Map to endurance or special? Use buff generic.
        case .accuracyUp: return .buff(.dexterity, def.magnitude)  // Approx
        case .evasionUp: return .buff(.agility, def.magnitude)  // Approx

        // Debuffs
        case .strengthDown: return .debuff(.strength, def.magnitude)
        case .enduranceDown: return .debuff(.endurance, def.magnitude)
        case .agilityDown: return .debuff(.agility, def.magnitude)
        case .speedDown: return .debuff(.speed, def.magnitude)
        case .intelligenceDown: return .debuff(.intelligence, def.magnitude)
        case .wisdomDown: return .debuff(.wisdom, def.magnitude)
        case .dexterityDown: return .debuff(.dexterity, def.magnitude)
        case .constitutionDown: return .debuff(.constitution, def.magnitude)
        case .perceptionDown: return .debuff(.perception, def.magnitude)
        case .luckDown: return .debuff(.luck, def.magnitude)
        case .willpowerDown: return .debuff(.willpower, def.magnitude)
        case .defenseDown: return .debuff(.endurance, def.magnitude)
        case .accuracyDown: return .debuff(.dexterity, def.magnitude)
        case .evasionDown: return .debuff(.agility, def.magnitude)
        }
    }

    private func resolveItem(source: PartyMember, item: Item, target: TargetScope) {
        if let index = source.inventory.firstIndex(where: { $0.id == item.id }) {
            source.inventory.remove(at: index)
        } else {
            delegate.log("\(source.name) fumbles for an item they don't have!")
            return
        }

        delegate.log("\(source.name) uses \(item.name).")

        switch item.type {
        case .potion:
            if case .singleAlly(let ally) = target {
                let heal = item.power
                ally.currentHP = min(ally.maxHP, ally.currentHP + heal)
                delegate.log("Recovered \(heal) HP to \(ally.name).")
            }
        case .manaPotion:
            if case .singleAlly(let ally) = target {
                let amount = item.power
                ally.currentMana = min(ally.maxMana, ally.currentMana + amount)
                delegate.log("Recovered \(amount) Mana to \(ally.name).")
            }
        case .revive:
            delegate.log("Revive not implemented.")
        default:
            delegate.log("Nothing happens. (Unhandled item type: \(item.type))")
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
            delegate.log("Victory! Gained \(totalXP) XP.")

            // Award XP (Naive implementation, assume World handles it or we iterate)
            for member in delegate.partyMembers.alivePartyMembers {
                member.addXP(totalXP)
                delegate.log("\(member.name) gained \(totalXP) XP.")
            }

            // Delay cleanup to show victory message
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.delegate.endCombat(result: .victory)
            }
            return true
        }

        if delegate.partyMembers.alivePartyMembers.isEmpty {
            phase = .defeat
            delegate.log("Party was wiped out...")
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.delegate.endCombat(result: .defeat)
            }
            return true
        }

        return false
    }
}

