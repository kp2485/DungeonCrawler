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
            let scale = viewModel.uiScale
            let topBarHeight = max(32 * scale, geometry.size.height * 0.05)
            let controlDeckHeight = max(120 * scale, geometry.size.height * 0.22)

            // Calculate available height for the middle section
            let middleHeight = max(geometry.size.height - topBarHeight - controlDeckHeight, 0)

            VStack(spacing: 0) {
                // Top Info Bar
                // Top Info Bar - Crystal Balls
                HStack(spacing: 12) {
                    Spacer()
                    // 1. Enchanted Blade (Red)
                    CrystalBall(
                        color: .red, active: viewModel.enchantedBladeActive, label: "BLADE")

                    // 2. Armorplate (Grey/White)
                    CrystalBall(
                        color: .white, active: viewModel.armorplateActive, label: "ARMOR")

                    // 3. Magic Screen (Blue)
                    CrystalBall(
                        color: .blue, active: viewModel.magicScreenActive, label: "SCREEN")

                    // 4. Detect Secret (Green + Pulse)
                    CrystalBall(
                        color: .green, active: viewModel.detectSecretActive, label: "SECRET",
                        pulsating: true)

                    // 5. Direction (Compass)
                    CompassBall(direction: viewModel.compassDirection)

                    // 6. Levitation (Cyan)
                    CrystalBall(
                        color: .cyan, active: viewModel.levitationActive, label: "FLOAT")
                    Spacer()
                }
                .frame(height: topBarHeight)
                .background(StoneBackground(bevel: false))
                .overlay(BevelBorder(width: 2, reversed: false))

                // 3D Viewport Frame
                ZStack {
                    StoneBackground(bevel: false)

                    HStack {
                        // LEFT COLUMN (Party Left)
                        VStack(spacing: 0) {
                            let portraitHeight = middleHeight / 3
                            ForEach(
                                [PartyPosition.frontLeft, .middleLeft, .backLeft], id: \.self
                            ) { pos in
                                PartyMemberPortrait(
                                    stats: viewModel.partyStats[pos], alignRight: false,
                                    sideColumnWidth: sideColumnWidth,
                                    sideColumnHeight: portraitHeight,
                                    scale: scale)
                            }
                        }
                        .frame(width: sideColumnWidth)
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

                        // RIGHT COLUMN (Party Right)
                        VStack(spacing: 0) {
                            let portraitHeight = middleHeight / 3
                            ForEach(
                                [PartyPosition.frontRight, .middleRight, .backRight], id: \.self
                            ) { pos in
                                PartyMemberPortrait(
                                    stats: viewModel.partyStats[pos], alignRight: true,
                                    sideColumnWidth: sideColumnWidth,
                                    sideColumnHeight: portraitHeight,
                                    scale: scale)
                            }
                        }
                        .frame(width: sideColumnWidth, height: middleHeight)
                        .background(StoneBackground())
                        .zIndex(1)
                    }
                }
                .frame(height: middleHeight).zIndex(1)

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
                        // Command Buttons / Pentagram (Left Panel)
                        ZStack {
                            StoneBackground(bevel: false)

                            if viewModel.isCombatActive {
                                CombatControlsView(viewModel: viewModel)
                                    .transition(.opacity)
                            } else {
                                // Pentagram Interface
                                PentagramView(
                                    scale: scale,
                                    onMove: { dir in
                                        world.perform(.move(direction: dir))
                                    },
                                    onTurnClockwise: {
                                        world.perform(.turnClockwise)
                                    },
                                    onTurnCounterClockwise: {
                                        world.perform(.turnCounterClockwise)
                                    },
                                    onAction: { action in
                                        print("Action triggered: \(action)")
                                        if action == "Open" {
                                            if let (coord, obj) = world.getObjectInFront() {
                                                viewModel.interactionTarget = coord
                                                viewModel.interactionObject = obj
                                                viewModel.isInteracting = true
                                            } else {
                                                world.log("Nothing to open there.")
                                            }
                                        } else if action == "Camp" {
                                            // Trigger rest?
                                        }
                                    }
                                )
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                        .frame(width: 280)  // Fixed width for buttons

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
                                        Spacer()
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
                        .frame(height: controlDeckHeight)

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
                                        .font(
                                            .system(
                                                size: 14, weight: .bold, design: .monospaced)
                                        )
                                        .foregroundColor(.stoneLight)
                                    Spacer()
                                }
                            }
                        }
                        .frame(width: 280)
                    }
                    .frame(height: controlDeckHeight)
                }
                .background(StoneBackground())
                .overlay(BevelBorder(width: 3, reversed: false))
            }
            .frame(maxWidth: .infinity)
            .frame(maxWidth: .infinity)
            .zIndex(0)

            // Interaction Overlay
            if viewModel.isInteracting {
                Color.black.opacity(0.8).edgesIgnoringSafeArea(.all)

                InteractionView(viewModel: viewModel)
                    .frame(width: 400, height: 300)
                    .transition(.scale)
                    .zIndex(100)
            }
        }

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
    var scale: CGFloat = 1.0

    var body: some View {
        let availableWidth = sideColumnWidth - 16
        let barWidth = availableWidth * 0.25
        let portraitWidth = availableWidth * 0.75
        let contentHeight = sideColumnHeight

        HStack(spacing: 4) {
            // Bars on Left (if alignRight)
            if alignRight {
                StatusBars(stats: stats)
                    .frame(width: barWidth, height: contentHeight)
            }

            // Portrait & Info Slot
            ZStack {
                // Background
                Color.black

                // Portrait Image (Placeholder)
                Image(systemName: "person.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.stoneLight)
                    .padding(8)
                    .opacity(0.3)

                // Name Overlay (Bottom)
                VStack {
                    Spacer()
                    Text(stats.name)
                        .font(.custom("Courier", size: 10 * scale))
                        .fontWeight(.bold)
                        .foregroundColor(.wizGold)
                        .frame(maxWidth: .infinity)
                        .background(Color.black.opacity(0.8))
                }

                // Initial Overlay (Top Left)
                VStack {
                    HStack {
                        Text(stats.name.prefix(2).uppercased())
                            .font(
                                .system(
                                    size: 20 * scale, weight: .heavy, design: .monospaced)
                            )
                            .foregroundColor(.white.opacity(0.4))
                            .padding(2)
                        Spacer()
                    }
                    Spacer()
                }

                // Weapon & Condition Overlay (Right Side of Portrait)
                HStack {
                    Spacer()
                    VStack(alignment: .trailing, spacing: 2) {
                        // Weapons (Primary / Secondary)
                        // Mocking weapon icons for now
                        Image(systemName: "sword")
                            .font(.system(size: 10 * scale))
                            .foregroundColor(.white)
                            .frame(width: 16 * scale, height: 16 * scale)
                            .background(Color.black.opacity(0.6))
                            .border(Color.stoneLight, width: 1)

                        Image(systemName: "shield")
                            .font(.system(size: 10 * scale))
                            .foregroundColor(.white)
                            .frame(width: 16 * scale, height: 16 * scale)
                            .background(Color.black.opacity(0.6))
                            .border(Color.stoneLight, width: 1)

                        Spacer()

                        // Conditions Row
                        if !stats.conditions.isEmpty {
                            VStack(spacing: 1) {
                                ForEach(
                                    Array(stats.conditions.prefix(3)), id: \.self
                                ) { condition in
                                    // Small icon representation
                                    Circle()
                                        .fill(Color.wizRed)
                                        .frame(width: 6, height: 6)
                                        .overlay(
                                            Circle().stroke(Color.white, lineWidth: 0.5))
                                }
                            }
                        }
                    }
                    .padding(2)
                }
            }
            .frame(width: portraitWidth, height: contentHeight)
            .background(Color.black)
            .overlay(
                BevelBorder(width: 2, reversed: true)
            )

            // Bars on Right (if !alignRight)
            if !alignRight {
                StatusBars(stats: stats)
                    .frame(width: barWidth, height: contentHeight)
            }
        }
        .padding(6)
        .background(
            ZStack {
                Color.stoneDark
                BevelBorder(width: 2, reversed: false)
            }
        )
    }
}

struct StatusBars: View {
    let stats: PartyMemberStats

    var body: some View {
        HStack(spacing: 2) {
            // HP (Red)
            VariableVerticalBar(
                color: .wizRed, current: stats.currentHP, max: stats.maxHP)

            // Stamina (Yellow)
            VariableVerticalBar(
                color: .yellow, current: stats.currentStamina, max: stats.maxStamina)

            // MP (Blue)
            VariableVerticalBar(
                color: .wizBlue, current: stats.currentMana, max: stats.maxMana)
        }
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
        .frame(minWidth: 4, maxWidth: .infinity)
    }
}
