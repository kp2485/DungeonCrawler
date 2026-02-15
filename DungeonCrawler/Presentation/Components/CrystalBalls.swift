//
//  CrystalBalls.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 01/03/2026.
//

import SwiftUI

struct CrystalBall: View {
    let color: Color
    let active: Bool
    let label: String
    var pulsating: Bool = false

    @State private var pulseOpactiy: Double = 0.3

    var body: some View {
        VStack(spacing: 2) {
            ZStack {
                // Base Sphere
                Circle()
                    .fill(
                        RadialGradient(
                            gradient: Gradient(colors: [
                                active ? color.opacity(0.8) : Color.gray.opacity(0.3),
                                active ? color.opacity(0.4) : Color.black.opacity(0.8),
                            ]),
                            center: .center,
                            startRadius: 2,
                            endRadius: 15
                        )
                    )
                    .frame(width: 24, height: 24)
                    .overlay(Circle().stroke(Color.stoneLight, lineWidth: 1))
                    .shadow(color: active ? color.opacity(0.8) : .clear, radius: active ? 4 : 0)

                // Shine
                Circle()
                    .trim(from: 0, to: 0.2)
                    .stroke(Color.white.opacity(0.6), lineWidth: 2)
                    .rotationEffect(.degrees(220))
                    .padding(2)

                // Pulsating effect for active states like Detect Secret
                if active && pulsating {
                    Circle()
                        .stroke(color, lineWidth: 2)
                        .scaleEffect(pulseOpactiy > 0.5 ? 1.2 : 1.0)
                        .opacity(pulseOpactiy)
                        .onAppear {
                            withAnimation(
                                .easeInOut(duration: 1.0).repeatForever(autoreverses: true)
                            ) {
                                pulseOpactiy = 0.8
                            }
                        }
                }
            }

            Text(label.prefix(1))  // Abbreviated label (E, A, M, S, D, L)
                .font(.system(size: 10, weight: .bold, design: .monospaced))
                .foregroundColor(active ? .wizGold : .stoneLight)
        }
        .frame(width: 32)
    }
}

struct CompassBall: View {
    let direction: CompassDirection

    var body: some View {
        ZStack {
            CrystalBall(color: .wizBlue, active: true, label: "DIR")

            // Needle / Letter
            Text(directionShort)
                .font(.system(size: 14, weight: .black, design: .serif))
                .foregroundColor(.white)
                .shadow(color: .black, radius: 1)
        }
    }

    var directionShort: String {
        switch direction {
        case .north: return "N"
        case .east: return "E"
        case .south: return "S"
        case .west: return "W"
        }
    }
}
