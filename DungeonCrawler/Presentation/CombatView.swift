//
//  CombatView.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/28/26.
//

import SwiftUI

struct CombatControlsView: View {
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
        ZStack {
            StoneBackground(bevel: false)

            if let member = viewModel.currentSelectionMember {
                VStack(spacing: 4) {
                    // Turn Indicator
                    HStack {
                        Text(member.name)
                            .font(.system(size: 14, weight: .bold, design: .monospaced))  // Monospaced for retro feel
                            .foregroundColor(Color.wizGold)
                            .shadow(color: .black, radius: 1, x: 1, y: 1)
                        Spacer()
                    }
                    .padding(.horizontal, 4)
                    .padding(.top, 4)

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
                        // No back button on main menu
                    } else {
                        RetroButton(label: "BACK", small: true) {
                            menuState = .main
                            selectedActionContext = nil
                        }
                        .padding(.bottom, 4)
                    }
                }
            } else {
                Text("Waiting...")
                    .font(.custom("Courier", size: 14))
                    .foregroundColor(.stoneLight)
            }
        }
        .frame(maxWidth: .infinity)
        // Removed border as parent container handles it
    }

    // ... (Keep existing menu methods: mainMenuGrid, abilitiesMenu, itemsMenu, targetsMenu, Helpers) ...
    // Note: Since I am replacing the whole file, I will paste the methods back in.

    // MARK: - Menus

    private func mainMenuGrid(member: PartyMember) -> some View {
        LazyVGrid(
            columns: [
                GridItem(.flexible()),
                GridItem(.flexible()),
            ], spacing: 4
        ) {

            // Row 1
            RetroButton(label: "FIGHT") {
                menuState = .targets(.attack)
            }
            RetroButton(label: "SPELL") {
                menuState = .abilities
            }

            // Row 2
            RetroButton(label: "DEFEND") {
                viewModel.world.combatEngine?.selectAction(for: member, action: .defend)
            }
            RetroButton(label: "ITEM") {
                menuState = .items
            }

            // Row 3 (Full Width Options)
            RetroButton(label: "RUN") {
                viewModel.world.combatEngine?.selectAction(for: member, action: .run)
            }
        }
        .padding(4)
    }

    private func abilitiesMenu(member: PartyMember) -> some View {
        VStack(spacing: 4) {
            Text("Select Ability").font(.system(size: 10)).foregroundColor(.stoneLight)
            ScrollView {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(member.abilities, id: \.self) { ability in
                        Button(action: {
                            menuState = .targets(.ability(ability))
                        }) {
                            HStack {
                                Text(ability.name)
                                    .font(.system(size: 12, design: .monospaced))
                                    .foregroundColor(.white)
                                Spacer()
                                Text("\(ability.manaCost) MP")
                                    .font(.system(size: 10, design: .monospaced))
                                    .foregroundColor(.wizBlue)
                            }
                            .padding(4)
                            .background(Color.stoneDark.opacity(0.5))
                            .border(Color.stoneLight.opacity(0.3), width: 1)
                        }
                        .buttonStyle(PlainButtonStyle())
                        .disabled(member.currentMana < ability.manaCost)
                    }
                }
            }
        }
        .padding(4)
    }

    private func itemsMenu(member: PartyMember) -> some View {
        VStack(spacing: 4) {
            Text("Select Item").font(.system(size: 10)).foregroundColor(.stoneLight)
            ScrollView {
                VStack(alignment: .leading, spacing: 2) {
                    ForEach(member.inventory, id: \.id) { item in
                        Button(action: {
                            menuState = .targets(.item(item))
                        }) {
                            HStack {
                                Text(item.name)
                                    .font(.system(size: 12, design: .monospaced))
                                    .foregroundColor(.white)
                                Spacer()
                            }
                            .padding(4)
                            .background(Color.stoneDark.opacity(0.5))
                            .border(Color.stoneLight.opacity(0.3), width: 1)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
        .padding(4)
    }

    private func targetsMenu(member: PartyMember, context: ActionContext) -> some View {
        VStack(spacing: 4) {
            Text("Select Target").font(.system(size: 10)).foregroundColor(.stoneLight)

            InsetPanel {
                ScrollView {
                    VStack(alignment: .leading, spacing: 2) {

                        // Logic to determine valid targets based on context
                        let targets = getPotentialTargets(context: context)

                        ForEach(targets, id: \.id) { target in
                            Button(action: {
                                executeAction(member: member, context: context, target: target)
                            }) {
                                HStack {
                                    Text(target.name)
                                        .font(.system(size: 12, design: .monospaced))
                                        .foregroundColor(target.isAlive ? .white : .gray)
                                    Spacer()
                                    Text("\(target.currentHP)/\(target.maxHP) HP")
                                        .font(.system(size: 10, design: .monospaced))
                                        .foregroundColor(getHealthColor(target))
                                }
                                .padding(4)
                                .background(Color.stoneDark.opacity(0.5))
                                //        .border(Color.stoneLight.opacity(0.3), width: 1)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(2)
                }
            }
        }
        .padding(4)
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
}

// MARK: - CombatEnemyListView

struct CombatEnemyListView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack {
                Text("ENEMIES")
                    .font(.system(size: 10, weight: .bold))
                    .foregroundColor(.stoneLight)
                Spacer()
            }
            .padding(4)
            .background(Color.black.opacity(0.8))

            InsetPanel {
                ScrollView {
                    VStack(spacing: 2) {
                        ForEach(viewModel.availableEnemies) { enemy in
                            HStack {
                                Text(enemy.name)
                                    .font(.system(size: 12, weight: .bold, design: .monospaced))
                                    .foregroundColor(enemy.isAlive ? .white : .gray)
                                Spacer()
                                Text(enemyHealthStatus(enemy))
                                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                                    .foregroundColor(getHealthColor(enemy))
                            }
                            .padding(4)
                            .background(
                                enemy.isAlive
                                    ? Color.stoneDark.opacity(0.3) : Color.black.opacity(0.5))
                        }
                    }
                    .padding(2)
                }
            }
        }
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
}

// Shared Helper
private func getHealthColor(_ combatant: Combatant) -> Color {
    let pct = Double(combatant.currentHP) / Double(combatant.maxHP)
    if pct < 0.25 { return .wizRed }
    if pct < 0.5 { return .wizGold }
    return .wizGreen
}
