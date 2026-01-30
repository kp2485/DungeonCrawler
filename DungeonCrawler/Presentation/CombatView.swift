//
//  CombatView.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/28/26.
//

import SwiftUI

struct CombatView: View {
    @ObservedObject var viewModel: ViewModel

    // Local State for Menu Navigation
    enum MenuState {
        case main
        case abilities
        case items
        case targets(ActionContext)
    }

    enum ActionContext {
        case attack
        case ability(Ability)
        case item(Item)
    }

    @State private var menuState: MenuState = .main
    @State private var selectedActionContext: ActionContext?

    var body: some View {
        HStack(spacing: 8) {
            // LEFT PANEL: Control Pad
            VStack {
                if let member = viewModel.currentSelectionMember {
                    // Turn Indicator
                    Text(member.name)
                        .dynamicTypeSize(.large)
                        .foregroundColor(Color.wizYellow)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 4)

                    // Menu Content
                    Group {
                        switch menuState {
                        case .main:
                            mainMenuGrid(member: member)
                        case .abilities:
                            abilitiesMenu(member: member)
                        case .items:
                            itemsMenu(member: member)
                        case .targets(let context):
                            targetsMenu(member: member, context: context)
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)

                    // Back Button
                    if case .main = menuState {
                        // Spacer to keep layout consistent
                    } else {
                        Button(action: {
                            menuState = .main
                            selectedActionContext = nil
                        }) {
                            Text("BACK")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity)
                                .padding(8)
                                .background(Color.black.opacity(0.5))
                                .border(Color.red, width: 1)
                        }
                    }
                } else {
                    Text("Waiting...")
                        .foregroundColor(.gray)
                }
            }
            .padding(8)
            .frame(maxWidth: .infinity)
            .background(.opacity(0.5))
            .border(Color.wizGray, width: 1)

            // RIGHT PANEL: Intel (Enemies)
            VStack(alignment: .leading, spacing: 4) {
                Text("ENEMIES")
                    .font(.caption)
                    .foregroundColor(.white)
                    .padding(.bottom, 2)

                ScrollView {
                    VStack(spacing: 2) {
                        ForEach(viewModel.availableEnemies) { enemy in
                            HStack {
                                Text(enemy.name)
                                    .fontWeight(.bold)
                                    .foregroundColor(enemy.isAlive ? .white : .gray)
                                Spacer()
                                Text(enemyHealthStatus(enemy))
                                    .font(.caption)
                                    .fontWeight(.bold)
                                    .foregroundColor(getHealthColor(enemy))
                            }
                            .padding(6)
                            .background(Color.black.opacity(0.6))
                            .overlay(Rectangle().stroke(Color.wizGray.opacity(0.5), lineWidth: 1))
                        }
                    }
                }
            }
            .padding(8)
            .frame(width: 200)  // Fixed width for enemy list
            .background(Color.black.opacity(0.5))
            .border(Color.wizGray, width: 1)
        }
        .frame(height: 200)  // Fixed total height for the combat container
        .background(.opacity(0.8))
    }

    // Helper for health description (Wizardry style)
    private func enemyHealthStatus(_ enemy: Enemy) -> String {
        if !enemy.isAlive { return "DEAD" }
        let pct = Double(enemy.currentHP) / Double(enemy.maxHP)
        if pct >= 1.0 { return "100%" }
        if pct > 0.75 { return ">75%" }
        if pct > 0.5 { return ">50%" }
        if pct > 0.25 { return ">25%" }
        return "CRIT"
    }

    // MARK: - Menus

    private func mainMenuGrid(member: PartyMember) -> some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
            ], spacing: 4
        ) {

            // Row 1
            CombatGridButton(label: "FIGHT", color: .red) {
                menuState = .targets(.attack)
            }
            CombatGridButton(label: "SPELL", color: .blue, disabled: member.abilities.isEmpty) {
                menuState = .abilities
            }

            // Row 2
            CombatGridButton(label: "DEFEND", color: .wizYellow) {
                viewModel.world.combatEngine?.selectAction(for: member, action: .defend)
            }
            CombatGridButton(label: "ITEM", color: .green, disabled: member.inventory.isEmpty) {
                menuState = .items
            }

            // Row 3 (Full Width Options)
            CombatGridButton(label: "RUN", color: .gray) {
                viewModel.world.combatEngine?.selectAction(for: member, action: .run)
            }
        }
    }

    private func abilitiesMenu(member: PartyMember) -> some View {
        VStack(spacing: 4) {
            Text("Select Ability").font(.caption).foregroundColor(.white)
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(member.abilities, id: \.self) { ability in
                        Button(action: {
                            menuState = .targets(.ability(ability))
                        }) {
                            HStack {
                                Text(ability.name).foregroundColor(.white)
                                Spacer()
                                Text("\(ability.manaCost) MP").foregroundColor(.blue)
                            }
                            .padding(4)
                            .background(Color.black.opacity(0.3))
                        }
                        .disabled(member.currentMana < ability.manaCost)
                    }
                }
            }
        }
    }

    private func itemsMenu(member: PartyMember) -> some View {
        VStack(spacing: 4) {
            Text("Select Item").font(.caption).foregroundColor(.white)
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(member.inventory, id: \.id) { item in
                        Button(action: {
                            menuState = .targets(.item(item))
                        }) {
                            HStack {
                                Text(item.name).foregroundColor(.white)
                                Spacer()
                            }
                            .padding(4)
                            .background(Color.black.opacity(0.3))
                        }
                    }
                }
            }
        }
    }

    private func targetsMenu(member: PartyMember, context: ActionContext) -> some View {
        VStack(spacing: 4) {
            Text("Select Target").font(.caption).foregroundColor(.white)

            ScrollView {
                VStack(alignment: .leading) {

                    // Logic to determine valid targets based on context
                    let targets = getPotentialTargets(context: context)

                    ForEach(targets, id: \.id) { target in
                        Button(action: {
                            executeAction(member: member, context: context, target: target)
                        }) {
                            HStack {
                                Text(target.name)
                                    .foregroundColor(target.isAlive ? .white : .gray)
                                Spacer()
                                Text("\(target.currentHP)/\(target.maxHP) HP")
                                    .font(.caption)
                                    .foregroundColor(getHealthColor(target))
                            }
                            .padding(4)
                            .background(Color.black.opacity(0.3))
                        }
                    }
                }
            }
        }
    }

    // MARK: - Helpers

    private func getPotentialTargets(context: ActionContext) -> [Combatant] {
        switch context {
        case .attack:
            // Enemies
            return viewModel.availableEnemies
        case .ability(let ability):
            switch ability.type {
            case .heal, .buff, .utility:  // Allies
                return viewModel.availablePartyMembers
            default:  // Enemies
                return viewModel.availableEnemies
            }
        case .item(let item):
            switch item.type {
            case .potion, .manaPotion, .revive:  // Allies
                return viewModel.availablePartyMembers
            }
        }
    }

    private func executeAction(member: PartyMember, context: ActionContext, target: Combatant) {
        guard let engine = viewModel.world.combatEngine else { return }

        var finalTarget: TargetScope?

        // Wrap target in Scope
        if let enemy = target as? Enemy {
            finalTarget = .singleEnemy(enemy)
        } else if let ally = target as? PartyMember {
            finalTarget = .singleAlly(ally)
        }

        guard let scope = finalTarget else { return }

        switch context {
        case .attack:
            engine.selectAction(for: member, action: .attack(target: scope))
        case .ability(let ability):
            // Defaulting powerLevel to 1 for now
            engine.selectAction(
                for: member, action: .cast(ability: ability, powerLevel: 1, target: scope))
        case .item(let item):
            engine.selectAction(for: member, action: .item(item: item, target: scope))
        }

        // Reset state for next time
        menuState = .main
    }

    private func getHealthColor(_ combatant: Combatant) -> Color {
        let pct = Double(combatant.currentHP) / Double(combatant.maxHP)
        if pct < 0.25 { return .red }
        if pct < 0.5 { return .yellow }
        return .green
    }
}

struct CombatGridButton: View {
    let label: String
    let color: Color
    var disabled: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(disabled ? .gray : .white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(disabled ? Color.black : color.opacity(0.6))
                .border(disabled ? Color.gray : color, width: 2)
        }
        .disabled(disabled)
        .buttonStyle(PlainButtonStyle())
    }
}
