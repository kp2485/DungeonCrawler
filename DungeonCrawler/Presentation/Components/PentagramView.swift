//
//  PentagramView.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2026.
//

import SwiftUI

struct PentagramView: View {
    let scale: CGFloat
    let onMove: (MovementDirection) -> Void
    let onTurnClockwise: () -> Void
    let onTurnCounterClockwise: () -> Void
    let onAction: (String) -> Void

    var body: some View {
        ZStack {
            // Background / Decal (The actual "Pentagram" art could go here)
            Circle()
                .stroke(Color.stoneDark, lineWidth: 2)
                .frame(width: 110 * scale, height: 110 * scale)
                .opacity(0.3)

            // Central Movement Cross
            VStack(spacing: 4 * scale) {
                // Forward
                PentagramArrowButton(icon: "arrow.up", scale: scale) {
                    onMove(.forward)
                }

                HStack(spacing: 4 * scale) {
                    // Turn Left
                    PentagramArrowButton(icon: "arrow.turn.up.left", scale: scale) {
                        onTurnCounterClockwise()
                    }

                    // Climb / Center Action (Context Sensitive)
                    Button(action: { onAction("Climb") }) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.stoneLight, .stoneMid], startPoint: .top,
                                        endPoint: .bottom)
                                )
                                .frame(width: 32 * scale, height: 32 * scale)
                                .overlay(Circle().stroke(Color.wizGold, lineWidth: 1))

                            Image(systemName: "ladder")
                                .font(.system(size: 16 * scale))
                                .foregroundColor(.black)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())

                    // Turn Right
                    PentagramArrowButton(icon: "arrow.turn.up.right", scale: scale) {
                        onTurnClockwise()
                    }
                }

                // Backwards
                PentagramArrowButton(icon: "arrow.down", scale: scale) {
                    onMove(.backwards)
                }
            }

            // Surrounding Actions (The 5 stars)
            // Top Left
            PentagramActionButton(
                label: "SEARCH", icon: "magnifyingglass", angle: 225, scale: scale
            ) {
                onAction("Search")
            }  // Top Left-ish
            .offset(x: -60 * scale, y: -40 * scale)

            // Top Right
            PentagramActionButton(
                label: "OPEN", icon: "door.left.hand.open", angle: 135, scale: scale
            ) {
                onAction("Open")
            }
            .offset(x: 60 * scale, y: -40 * scale)

            // Bottom Left
            PentagramActionButton(label: "USE", icon: "hand.tap", angle: 315, scale: scale) {
                onAction("Use")
            }
            .offset(x: -60 * scale, y: 40 * scale)

            // Bottom Right
            PentagramActionButton(label: "DISK", icon: "opticaldisc", angle: 45, scale: scale) {
                onAction("Disk")
            }
            .offset(x: 60 * scale, y: 40 * scale)

            // Bottom Center (Spell)
            PentagramActionButton(label: "SPELL", icon: "book.closed", angle: 0, scale: scale) {
                onAction("Spell")
            }
            .offset(y: 70 * scale)
        }
        .frame(width: 200 * scale, height: 160 * scale)
    }
}

struct PentagramArrowButton: View {
    let icon: String  // System name
    let scale: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .fill(Color.stoneMid)
                    .frame(width: 32 * scale, height: 32 * scale)
                    .overlay(BevelBorder(width: 1, reversed: false))

                Image(systemName: icon)
                    .font(.system(size: 16 * scale, weight: .bold))
                    .foregroundColor(.wizGold)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct PentagramActionButton: View {
    let label: String
    let icon: String
    let angle: Double
    let scale: CGFloat
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 2) {
                ZStack {
                    Circle()
                        .fill(Color.stoneDark)
                        .frame(width: 36 * scale, height: 36 * scale)
                        .overlay(Circle().stroke(Color.stoneLight, lineWidth: 1))
                        .shadow(radius: 2)

                    Image(systemName: icon)
                        .font(.system(size: 18 * scale))
                        .foregroundColor(.wizGold)
                }

                Text(label)
                    .font(.system(size: 8 * scale, weight: .bold, design: .monospaced))
                    .foregroundColor(.stoneLight)
                    .shadow(color: .black, radius: 1)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
