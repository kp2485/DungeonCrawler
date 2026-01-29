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
        VStack {
            if let member = viewModel.currentSelectionMember {

                // Header: Who is acting?
                Text("\(member.name)'s Turn")
                    .font(.headline)
                    .foregroundColor(.gold)
                    .padding(.bottom, 4)

                // Menu Content
                switch menuState {
                case .main:
                    mainMenu(member: member)
                case .abilities:
                    abilitiesMenu(member: member)
                case .items:
                    itemsMenu(member: member)
                case .targets(let context):
                    targetsMenu(member: member, context: context)
                }

                // Back Button (if not at main)
                if case .main = menuState {
                    // No back
                } else {
                    Button("Back") {
                        menuState = .main
                        selectedActionContext = nil
                    }
                    .foregroundColor(.red)
                    .padding(.top, 8)
                }

            } else {
                Text("Waiting...")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(StoneBackground())
        .border(Color.gold, width: 2)
    }

    // MARK: - Menus

    private func mainMenu(member: PartyMember) -> some View {
        VStack(spacing: 8) {
            GoldButton(label: "ATTACK") {
                // If single enemy, maybe auto-select? For now, go to target select
                menuState = .targets(.attack)
            }

            GoldButton(label: "MAGIC") {
                menuState = .abilities
            }
            .disabled(member.abilities.isEmpty)

            GoldButton(label: "ITEM") {
                menuState = .items
            }
            .disabled(member.inventory.isEmpty)

            GoldButton(label: "DEFEND") {
                viewModel.world.combatEngine?.selectAction(for: member, action: .defend)
            }

            GoldButton(label: "RUN") {
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
            .frame(height: 100)
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
            .frame(height: 100)
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
            .frame(height: 100)
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
