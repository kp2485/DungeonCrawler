//
//  ContentView.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 22/02/2025.
//

import RealityKit
import SwiftUI

struct ContentView: View {
    // World is now accessed via ViewModel
    var world: World { viewModel.world }
    @ObservedObject var viewModel: ViewModel

    // Init removed, as ViewModel is injected

    // MARK: - Layout Constants
    private let viewportAspectRatio: CGFloat = 4.0 / 3.0

    // MARK: - Visual Effects State
    @State private var shakeOffset: CGFloat = 0
    @State private var flashColor: Color?
    @State private var flashOpacity: Double = 0

    var body: some View {
        GeometryReader { geometry in
            let sideColumnWidth = geometry.size.width / 8
            let sideColumnHeight = geometry.size.height / 4
            HStack(spacing: 0) {
                // CENTER COLUMN (Viewport + Controls)
                VStack(spacing: 0) {
                    // Top Info Bar
                    HStack {
                        Spacer()
                        Text("DUNGEON LEVEL \(world.currentFloorIndex + 1)")
                            .font(.custom("Courier", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.wizGold)
                            .shadow(color: .black, radius: 1, x: 1, y: 1)
                        Spacer()
                    }
                    .frame(height: 32)
                    .background(StoneBackground(bevel: false))
                    .overlay(BevelBorder(width: 2, reversed: false))

                    // 3D Viewport Frame
                    ZStack {
                        StoneBackground(bevel: false)
                        
                        HStack {
                            // LEFT COLUMN (Party Left)
                            VStack(spacing: 15) {
                                ForEach([PartyPosition.frontLeft, .middleLeft, .backLeft], id: \.self) { pos in
                                    PartyMemberPortrait(stats: viewModel.partyStats[pos], alignRight: false, sideColumnWidth: sideColumnWidth, sideColumnHeight: sideColumnHeight)
                                }
                                Spacer()
                            }
                            .frame(width: sideColumnWidth, height: sideColumnHeight)
                            .padding(.vertical, 8)
                            .background(StoneBackground())
                            .zIndex(1)
                            
                            InsetPanel {
                                ZStack {
                                    GameView(world: world)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .aspectRatio(viewportAspectRatio, contentMode: .fit)
                                        .offset(x: shakeOffset)
                                    
                                    // Flash Overlay
                                    if let color = flashColor {
                                        color
                                            .opacity(flashOpacity)
                                            .allowsHitTesting(false)
                                    }
                                }
                            }
                            .padding(12)
                            
                            // RIGHT COLUMN (Party Right)
                            VStack(spacing: 15) {
                                ForEach([PartyPosition.frontRight, .middleRight, .backRight], id: \.self) { pos in
                                    PartyMemberPortrait(stats: viewModel.partyStats[pos], alignRight: true, sideColumnWidth: sideColumnWidth, sideColumnHeight: sideColumnHeight)
                                }
                                Spacer()
                            }
                            .frame(width: sideColumnWidth, height: sideColumnHeight)
                            .padding(.vertical, 8)
                            .background(StoneBackground())
                            .zIndex(1)
                        }
                    }

                    // Control Deck
                    VStack(spacing: 0) {
                        // Active Combatant / Status Strip
                        if let active = viewModel.activeCombatantName {
                            HStack {
                                Spacer()
                                Text("- \(active) -")
                                    .font(.headline)
                                    .foregroundColor(.wizRed)
                                    .shadow(color: .black, radius: 1)
                                Spacer()
                            }
                            .frame(height: 24)
                            .background(Color.black.opacity(0.8))
                            .border(Color.stoneLight, width: 1)
                        }

                        HStack(alignment: .top, spacing: 0) {
                            // Command Buttons (Left Panel)
                            ZStack {
                                StoneBackground(bevel: false)

                                if viewModel.isCombatActive {
                                    CombatControlsView(viewModel: viewModel)
                                        .transition(.opacity)
                                } else {
                                    HStack(spacing: 8) {
                                        // Action Group
                                        VStack(spacing: 4) {
                                            RetroButton(label: "FIGHT") { /* Attack */  }
                                            RetroButton(label: "SPELL") { /* Cast */  }
                                            RetroButton(label: "ITEMS") { /* Use Item */  }
                                        }

                                        // Movement Group
                                        VStack(spacing: 4) {
                                            RetroButton(label: "MOVE") { /* Toggle Move */  }
                                            HStack(spacing: 4) {
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
                                        VStack(spacing: 4) {
                                            RetroButton(label: "CAMP") { /* Rest */  }
                                            RetroButton(label: "TEST") {
                                                let enemy = Enemy(position: world.partyPosition)
                                                world.startCombat(with: enemy)
                                            }
                                        }
                                    }
                                    .padding(8)
                                }
                            }
                            .frame(width: 280)  // Fixed width for buttons

                            // Separator
                            Rectangle()
                                .fill(Color.stoneDark)
                                .frame(width: 4)
                                .overlay(BevelBorder(width: 1))

                            // Game Log (Center Panel)
                            InsetPanel {
                                ScrollViewReader { proxy in
                                    ScrollView {
                                        VStack(alignment: .leading, spacing: 2) {
                                            ForEach(viewModel.gameLog, id: \.self) { log in
                                                Text(log)
                                                    .font(.custom("Courier", size: 12))
                                                    .foregroundColor(.wizGreen)
                                                    .frame(maxWidth: .infinity, alignment: .leading)
                                            }
                                        }
                                        .padding(4)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .onChange(of: viewModel.gameLog.count) { oldValue, newValue in
                                        if oldValue != newValue, let last = viewModel.gameLog.last {
                                            proxy.scrollTo(last)
                                        }
                                    }
                                }
                            }
                            .frame(height: 110)

                            // Separator
                            Rectangle()
                                .fill(Color.stoneDark)
                                .frame(width: 4)
                                .overlay(BevelBorder(width: 1))

                            // Map/Selection Panel (Right Panel)
                            ZStack {
                                StoneBackground(bevel: false)

                                if viewModel.isCombatActive {
                                    CombatEnemyListView(viewModel: viewModel)
                                        .transition(.opacity)
                                } else {
                                    // Placeholder for MiniMap
                                    VStack {
                                        Spacer()
                                        Text("MAP AREA")
                                            .font(.system(size: 14, weight: .bold, design: .monospaced))
                                            .foregroundColor(.stoneLight)
                                        Spacer()
                                    }
                                }
                            }
                            .frame(width: 280)
                        }
                        .frame(height: 120)
                    }
                    .background(StoneBackground())
                    .overlay(BevelBorder(width: 3, reversed: false))
                }
                .frame(maxWidth: .infinity)
                .zIndex(0)
            }
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
                    Circle().fill(Color.wizGold).frame(width: 8, height: 8)  // Hidden
                    Circle().fill(Color.wizRed).frame(width: 8, height: 8)  // Danger
                }
                .padding(4)
                .background(Color.black)
                .cornerRadius(4)
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.stoneLight, lineWidth: 1))
                .padding(.top, 40)  // Below notch/safe area
                Spacer()
            }, alignment: .top
        )
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

struct PartyMemberPortrait: View {
    let stats: PartyMemberStats
    var alignRight: Bool = false
    var sideColumnWidth: CGFloat
    var sideColumnHeight: CGFloat

    var body: some View {
        HStack(spacing: 4) {
            // Bars on Left (if alignRight)
            if alignRight {
                StatusBars(stats: stats)
            }

            // Portrait Slot
            ZStack {
                // Background
                Color.black

                // Generic Portrait (Placeholder)
                Image(systemName: "person.fill")
                    .resizable()
                    .foregroundColor(.stoneLight)
                    .padding(8)
                    .opacity(0.3)

                // Name Overlay (Bottom)
                VStack {
                    Spacer()
                    Text(stats.name)
                        .font(.custom("Courier", size: 10))
                        .fontWeight(.bold)
                        .foregroundColor(.wizGold)
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.8))
                }

                // Initial Overlay (Top Left)
                VStack {
                    HStack {
                        Text(stats.name.prefix(2).uppercased())
                            .font(.system(size: 20, weight: .heavy, design: .monospaced))
                            .foregroundColor(.white.opacity(0.4))
                            .padding(2)
                        Spacer()
                    }
                    Spacer()
                }

                // Condition Badges (Top Right)
                if !stats.conditions.isEmpty {
                    VStack {
                        HStack {
                            Spacer()
                            ForEach(Array(stats.conditions.prefix(2)), id: \.self) { condition in
                                Circle()
                                    .fill(Color.wizRed)
                                    .frame(width: 8, height: 8)
                                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            }
                        }
                        .padding(2)
                        Spacer()
                    }
                }
            }
            .frame(width: sideColumnWidth * 0.9, height: sideColumnHeight * 0.9)
            .background(Color.black)
            .overlay(
                BevelBorder(width: 2, reversed: true)
            )

            // Bars on Right (if !alignRight)
            if !alignRight {
                StatusBars(stats: stats)
            }
        }
        .padding(6)
        .background(
            ZStack {
                Color.stoneDark
                BevelBorder(width: 2, reversed: false)
            }
        )
        .padding(.vertical, 2)
    }
}

struct StatusBars: View {
    let stats: PartyMemberStats

    var body: some View {
        HStack(spacing: 2) {
            // HP
            VariableVerticalBar(color: .wizRed, current: stats.currentHP, max: stats.maxHP)
            // MP
            VariableVerticalBar(color: .wizBlue, current: stats.currentMana, max: stats.maxMana)
            // Stamina (Placeholder)
            VariableVerticalBar(color: .wizGreen, current: 100, max: 100)
        }
        .frame(width: 24, height: 60)
        .padding(2)
        .background(Color.black)
        .overlay(BevelBorder(width: 1, reversed: true))
    }
}

struct VariableVerticalBar: View {
    let color: Color
    let current: Int
    let max: Int

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .bottom) {
                Color.stoneDark.opacity(0.5)
                color
                    .frame(
                        height: geo.size.height * (CGFloat(current) / CGFloat(max > 0 ? max : 1)))
            }
        }
        .frame(width: 6)
    }
}

