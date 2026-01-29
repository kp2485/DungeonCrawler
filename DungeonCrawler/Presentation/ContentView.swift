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

    // MARK: - Layout Constants
    private let sideColumnWidth: CGFloat = 120
    private let viewportAspectRatio: CGFloat = 4.0 / 3.0

    var body: some View {
        HStack(spacing: 0) {
            // LEFT COLUMN (Party Left)
            VStack(spacing: 4) {
                PartyMemberPortrait(stats: viewModel.partyStats[.frontLeft])
                Spacer()
                PartyMemberPortrait(stats: viewModel.partyStats[.backLeft])
            }
            .frame(width: sideColumnWidth)
            .background(StoneBackground())

            // CENTER COLUMN (Viewport + Controls)
            VStack(spacing: 0) {
                // Top Info Bar (optional, maybe compass)
                HStack {
                    Spacer()
                    Text("DUNGEON LEVEL \(world.currentFloorIndex + 1)")
                        .font(.custom("Courier", size: 14))
                        .fontWeight(.bold)
                        .foregroundColor(.gold)
                    Spacer()
                }
                .frame(height: 30)
                .background(StoneBackground().brightness(-0.1))

                // 3D Viewport
                ZStack {
                    GameView(world: world)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .aspectRatio(viewportAspectRatio, contentMode: .fit)
                        .border(Color.gray, width: 4)
                }
                .padding(8)
                .background(Color.black)

                // Active Combatant / Status
                if let active = viewModel.activeCombatantName {
                    Text("- \(active) -")
                        .font(.headline)
                        .foregroundColor(.red)
                        .padding(4)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                }

                // Game Log & Controls
                VStack(spacing: 0) {
                    ScrollViewReader { proxy in
                        ScrollView {
                            VStack(alignment: .leading, spacing: 2) {
                                ForEach(viewModel.gameLog, id: \.self) { log in
                                    Text(log)
                                        .font(.custom("Courier", size: 14))
                                        .foregroundColor(.green)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            .padding(4)
                        }
                        .frame(height: 100)
                        .background(Color.black)
                        .border(Color.gray, width: 2)
                        .onChange(of: viewModel.gameLog.count) { oldValue, newValue in
                            if oldValue != newValue, let last = viewModel.gameLog.last {
                                proxy.scrollTo(last)
                            }
                        }
                    }

                    // Command Buttons (Grid)
                    HStack(alignment: .top, spacing: 8) {
                        // Combat Commands
                        VStack(spacing: 4) {
                            GoldButton(label: "FIGHT") { world.perform(.attack) }
                                .disabled(!viewModel.isCombatActive)
                            GoldButton(label: "PARRY") { world.perform(.wait) }  // Wait as Parry
                            GoldButton(label: "SPELL") { /* Open Magic Menu */  }
                                .disabled(!viewModel.isCombatActive)
                        }

                        // Exploration / Interaction
                        VStack(spacing: 4) {
                            GoldButton(label: "MOVE") { /* Toggle Move Mode */  }
                            GoldButton(label: "LOOK") { /* Inspect */  }
                            GoldButton(label: "CAMP") { /* Rest */  }
                        }

                        // Movement (Mini-pad)
                        if !viewModel.isCombatActive {
                            VStack(spacing: 2) {
                                GoldButton(label: "▲", small: true) {
                                    world.perform(.move(direction: .forward))
                                }
                                HStack(spacing: 2) {
                                    GoldButton(label: "◄", small: true) {
                                        world.perform(.turnCounterClockwise)
                                    }
                                    GoldButton(label: "▼", small: true) {
                                        world.perform(.move(direction: .backwards))
                                    }
                                    GoldButton(label: "►", small: true) {
                                        world.perform(.turnClockwise)
                                    }
                                }
                            }
                        }
                    }
                    .padding(8)
                }
                .background(StoneBackground())
            }
            .frame(maxWidth: .infinity)

            // RIGHT COLUMN (Party Right)
            VStack(spacing: 4) {
                PartyMemberPortrait(stats: viewModel.partyStats[.frontRight])
                Spacer()
                PartyMemberPortrait(stats: viewModel.partyStats[.backRight])
            }
            .frame(width: sideColumnWidth)
            .background(StoneBackground())
        }
        .edgesIgnoringSafeArea(.all)
#if os(iOS) || os(tvOS)
        .statusBar(hidden: true)
#endif
    }
}

// MARK: - Components

struct StoneBackground: View {
    var body: some View {
        Color(white: 0.2)
            .overlay(
                Image(systemName: "square.fill")  // Placeholder for texture
                    .resizable()
                    .opacity(0.1)
                    .foregroundColor(.black)
            )
        // In a real app we'd use a tiled stone image asset
    }
}

extension Color {
    static let gold = Color(red: 0.8, green: 0.7, blue: 0.2)
}

struct GoldButton: View {
    let label: String
    var small: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .fill(Color.gold)
                    .overlay(
                        Rectangle()
                            .stroke(Color.white.opacity(0.5), lineWidth: 2)
                    )
                    .shadow(radius: 1, y: 1)

                Text(label)
                    .font(.system(size: small ? 12 : 14, weight: .bold, design: .monospaced))
                    .foregroundColor(.black)
            }
            .frame(width: small ? 40 : 80, height: small ? 30 : 30)
        }
    }
}

struct PartyMemberPortrait: View {
    let stats: PartyMemberStats

    var body: some View {
        VStack(spacing: 2) {
            // Portrait Placeholder
            Rectangle()
                .fill(Color.gray)
                .frame(width: 80, height: 80)
                .overlay(Text(String(stats.name.prefix(1))).font(.largeTitle))
                .border(Color.gold, width: 2)

            Text(stats.name)
                .font(.caption)
                .bold()
                .foregroundColor(.white)
                .lineLimit(1)

            Text(stats.title)
                .font(.caption2)
                .foregroundColor(.gold)

            // Bars
            HStack(spacing: 4) {
                // HP Bar (Red)
                VStack {
                    ZStack(alignment: .bottom) {
                        Rectangle().fill(Color.gray)
                        Rectangle().fill(Color.red)
                            .frame(
                                height: CGFloat(stats.currentHP) / CGFloat(max(1, stats.maxHP)) * 60
                            )
                    }
                    .frame(width: 8, height: 60)
                }

                // MP Bar (Blue)
                VStack {
                    ZStack(alignment: .bottom) {
                        Rectangle().fill(Color.gray)
                        Rectangle().fill(Color.blue)
                            .frame(
                                height: CGFloat(stats.currentMana) / CGFloat(max(1, stats.maxMana))
                                    * 60)
                    }
                    .frame(width: 8, height: 60)
                }

                // Stamina (Yellow) - Placeholder
                VStack {
                    Rectangle().fill(Color.yellow).frame(width: 8, height: 60)
                }
            }
        }
        .padding(8)
        .background(Color.black.opacity(0.5))
        .cornerRadius(4)
    }
}

#Preview {
    ContentView()
}
