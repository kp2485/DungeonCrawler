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
            #.#..#
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

    // MARK: - Visual Effects State
    @State private var shakeOffset: CGFloat = 0
    @State private var flashColor: Color?
    @State private var flashOpacity: Double = 0

    var body: some View {
        HStack(spacing: 0) {
            // LEFT COLUMN (Party Left)
            VStack(spacing: 4) {
                PartyMemberPortrait(stats: viewModel.partyStats[.frontLeft])
                Spacer()
                PartyMemberPortrait(stats: viewModel.partyStats[.middleLeft])
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
                        .offset(x: shakeOffset)

                    // Flash Overlay
                    if let color = flashColor {
                        color
                            .opacity(flashOpacity)
                            .allowsHitTesting(false)
                    }
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
                    ZStack(alignment: .top) {
                        if viewModel.isCombatActive {
                            CombatView(viewModel: viewModel)
                                .transition(.opacity)
                        } else {
                            HStack(alignment: .top, spacing: 4) {
                                // Action Group
                                VStack(spacing: 2) {
                                    RetroButton(label: "FIGHT") { /* Attack */  }
                                    RetroButton(label: "SPELL") { /* Cast */  }
                                    RetroButton(label: "ITEMS") { /* Use Item */  }
                                }

                                // Movement Group
                                VStack(spacing: 2) {
                                    RetroButton(label: "MOVE") { /* Toggle Move */  }
                                    HStack(spacing: 2) {
                                        RetroButton(label: "Q", small: true) {
                                            world.perform(.turnCounterClockwise)
                                        }
                                        RetroButton(label: "W", small: true) {
                                            world.perform(.move(direction: .forward))
                                        }
                                        RetroButton(label: "E", small: true) {
                                            world.perform(.turnClockwise)
                                        }
                                    }
                                    RetroButton(label: "S", small: true) {
                                        world.perform(.move(direction: .backwards))
                                    }
                                }

                                // System Group
                                VStack(spacing: 2) {
                                    RetroButton(label: "CAMP") { /* Rest */  }
                                    RetroButton(label: "TEST") {
                                        let enemy = Enemy(position: world.partyPosition)
                                        world.startCombat(with: enemy)
                                    }
                                }
                            }
                            .padding(4)
                            .transition(.opacity)
                        }
                    }
                    .frame(height: 120)
                    .frame(maxWidth: .infinity)
                    .background(Color.black.opacity(0.3))
                }
                .background(StoneBackground())
                .overlay(Rectangle().stroke(Color.wizGray, lineWidth: 2))
            }
            .frame(maxWidth: .infinity)

            // RIGHT COLUMN (Party Right)
            VStack(spacing: 4) {
                ForEach([PartyPosition.frontRight, .middleRight, .backRight], id: \.self) { pos in
                    PartyMemberPortrait(stats: viewModel.partyStats[pos], alignRight: true)
                }
                Spacer()
            }
            .frame(width: sideColumnWidth)
            .padding(.vertical, 4)
            .background(StoneBackground())
        }
        .edgesIgnoringSafeArea(.all)
        #if os(iOS) || os(tvOS)
            .statusBar(hidden: true)
        #endif
        .onChange(of: viewModel.lastVisualEffect) { oldValue, newValue in
            guard let effect = newValue else { return }
            triggerEffect(effect)
        }
        .overlay(
            // Top Movement Indicator Strip
            VStack {
                HStack(spacing: 20) {
                    Circle().fill(Color.green).frame(width: 8, height: 8)  // Valid Move
                    Circle().fill(Color.wizYellow).frame(width: 8, height: 8)  // Hidden
                    Circle().fill(Color.wizRed).frame(width: 8, height: 8)  // Danger
                }
                .padding(4)
                .background(Color.black)
                .cornerRadius(4)
                .padding(.top, 40)  // Below notch/safe area
                Spacer()
            }, alignment: .top
        )
        .onAppear {
            // Force light status bar if needed
        }
    }

    private func triggerEffect(_ effect: CombatVisualEffect) {
        switch effect {
        case .shake:
            withAnimation(.linear(duration: 0.05)) { shakeOffset = -10 }
            withAnimation(.linear(duration: 0.05).delay(0.05)) { shakeOffset = 10 }
            withAnimation(.linear(duration: 0.05).delay(0.1)) { shakeOffset = -5 }
            withAnimation(.linear(duration: 0.05).delay(0.15)) { shakeOffset = 5 }
            withAnimation(.linear(duration: 0.05).delay(0.2)) { shakeOffset = 0 }
        case .flashRed:
            flashColor = .red
            flashOpacity = 0.5
            withAnimation(.easeOut(duration: 0.5)) { flashOpacity = 0 }
        case .flashGreen:
            flashColor = .green
            flashOpacity = 0.3
            withAnimation(.easeOut(duration: 0.5)) { flashOpacity = 0 }
        }
    }
}

// MARK: - Components

// MARK: - Components
// StoneBackground, Color.gold, and GoldButton moved to Styles.swift

struct PartyMemberPortrait: View {
    let stats: PartyMemberStats
    var alignRight: Bool = false

    var body: some View {
        HStack(spacing: 2) {
            // Bars on Left (if alignRight)
            if alignRight {
                StatusBars(stats: stats)
            }

            // Portrait
            ZStack {
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 64, height: 64)
                    .overlay(
                        Text(stats.name.prefix(2).uppercased())
                            .font(.system(size: 24, weight: .heavy, design: .monospaced))
                            .foregroundColor(.white.opacity(0.5))
                    )
                    .border(Color.wizGray, width: 3)

                // Name Overlay (Bottom)
                VStack {
                    Spacer()
                    Text(stats.name)
                        .font(.custom("Courier", size: 10))
                        .fontWeight(.bold)
                        .foregroundColor(.gold)
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.7))
                }

                // Condition Badges (Top Right)
                if !stats.conditions.isEmpty {
                    VStack {
                        HStack {
                            Spacer()
                            Text(stats.conditions.first!.prefix(1))
                                .font(.system(size: 8, weight: .black))
                                .frame(width: 12, height: 12)
                                .background(Color.red)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                }
            }
            .frame(width: 64, height: 64)

            // Bars on Right (if !alignRight)
            if !alignRight {
                StatusBars(stats: stats)
            }
        }
        .padding(4)
        .background(Color.black.opacity(0.5))
        .border(Color.wizGray, width: 1)
    }
}

struct StatusBars: View {
    let stats: PartyMemberStats

    var body: some View {
        HStack(spacing: 1) {
            // HP
            VariableVerticalBar(color: .wizRed, current: stats.currentHP, max: stats.maxHP)
            // MP
            VariableVerticalBar(color: .wizBlue, current: stats.currentMana, max: stats.maxMana)
            // Stamina (Placeholder)
            VariableVerticalBar(color: .wizYellow, current: 100, max: 100)
        }
        .frame(width: 24, height: 60)
        .background(Color.black)
        .border(Color.gray, width: 1)
    }
}

struct VariableVerticalBar: View {
    let color: Color
    let current: Int
    let max: Int

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                Color.black
                color
                    .frame(
                        height: geo.size.height * (CGFloat(current) / CGFloat(max > 0 ? max : 1)))
            }
        }
        .frame(width: 6)
    }
}

struct RetroButton: View {
    let label: String
    var small: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.system(size: small ? 10 : 12, weight: .bold, design: .monospaced))
                .foregroundColor(.gold)
                .frame(width: small ? 30 : 60, height: small ? 20 : 25)
                .background(
                    ZStack {
                        Color.black
                        Rectangle().stroke(Color.wizGray, lineWidth: 2)
                    }
                )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ContentView()
}
