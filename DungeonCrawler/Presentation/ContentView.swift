//
//  ContentView.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 22/02/2025.
//

import RealityKit
import SwiftUI

struct ContentView: View {
    let world: World
    @ObservedObject var viewModel: ViewModel

    init() {
        world = makeWorld([
            """
            ######
            #S.#.#
            #....#
            #e.e.#
            #<#..#
            ######
            """,
            """
            ######
            #....#
            #....#
            ###..#
            #>#..#
            #T...#
            ######
            """,
        ])

        viewModel = ViewModel(world: world)
    }

    var body: some View {
        ZStack {
            GameView(world: world)
            VStack {
                HStack {
                    if viewModel.isCombatActive {
                        VStack(alignment: .leading) {
                            Text("COMBAT ACTIVE")
                                .font(.headline)
                                .foregroundColor(.red)
                            Text("Turn Order:")
                            ForEach(viewModel.turnQueue, id: \.self) { name in
                                Text(name)
                                    .fontWeight(
                                        viewModel.activeCombatantName
                                            == name.components(separatedBy: " (").first
                                            ? .bold : .regular
                                    )
                                    .foregroundColor(
                                        viewModel.activeCombatantName
                                            == name.components(separatedBy: " (").first
                                            ? .yellow : .white)
                            }
                        }
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(10)
                    }
                    Spacer()
                    PartyMembersView(partyStats: viewModel.partyStats)
                }
                Spacer()
            }
            VStack {
                VStack {
                    Text("State: \(viewModel.worldState)")
                    if let active = viewModel.activeCombatantName {
                        Text("Active: \(active)")
                            .foregroundColor(.yellow)
                    }
                }
                .background(Color.gray.opacity(0.2))
                .foregroundStyle(.white)

                HStack {
                    Button("Turn CCW") {
                        world.perform(.turnCounterClockwise)
                    }.keyboardShortcut("q", modifiers: [])
                    Button("Forward") {
                        world.perform(.move(direction: .forward))
                    }.keyboardShortcut("w", modifiers: [])
                    Button("Turn CW") {
                        world.perform(.turnClockwise)
                    }.keyboardShortcut("e", modifiers: [])
                }

                HStack {
                    Button("Left") {
                        world.perform(.move(direction: .left))
                    }.keyboardShortcut("a", modifiers: [])
                    Button("Back") {
                        world.perform(.move(direction: .backwards))
                    }.keyboardShortcut("s", modifiers: [])
                    Button("Right") {
                        world.perform(.move(direction: .right))
                    }.keyboardShortcut("d", modifiers: [])

                }

                HStack {
                    Button("Attack") {
                        world.perform(.attack)
                    }
                    .keyboardShortcut("f", modifiers: [])
                    .disabled(!viewModel.isCombatActive)

                    Button("Wait") {
                        world.perform(.wait)
                    }
                    .keyboardShortcut("r", modifiers: [])
                    .disabled(!viewModel.isCombatActive)
                }

                // Ability Buttons
                if viewModel.isCombatActive && !viewModel.activeAbilities.isEmpty {
                    ScrollView(.horizontal) {
                        HStack {
                            ForEach(viewModel.activeAbilities, id: \.self) { ability in
                                Button(ability.name) {
                                    world.perform(.ability(ability))
                                }
                                .padding(4)
                                .background(Color.blue)
                                .cornerRadius(8)
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
