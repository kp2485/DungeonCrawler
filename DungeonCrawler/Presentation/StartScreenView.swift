//
//  StartScreenView.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/29/26.
//

import SwiftUI

struct StartScreenView: View {
    @Binding var currentScreen: AppScreen

    var body: some View {
        ZStack {
            // Background
            StoneBackground()
                .edgesIgnoringSafeArea(.all)

            // Dark Overlay for contrast
            Color.black.opacity(0.3)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 40) {
                // Title
                VStack(spacing: 8) {
                    Text("THE LABYRINTH")
                        .font(.system(size: 60, weight: .black, design: .serif))
                        .foregroundColor(.gold)
                        .shadow(color: .black, radius: 2, x: 2, y: 2)

                    Text("OF THE PANTHEON")
                        .font(.system(size: 24, weight: .bold, design: .serif))
                        .foregroundColor(.white.opacity(0.8))
                        .tracking(4)
                }
                .padding(.bottom, 40)

                // Menu Buttons
                VStack(spacing: 20) {
                    MenuButton(title: "TEST DUNGEON") {
                        currentScreen = .game
                    }

                    MenuButton(title: "CREATE CHARACTER") {
                        currentScreen = .createCharacter
                    }

                    MenuButton(title: "ASSEMBLE PARTY") {
                        currentScreen = .assembleParty
                    }

                    MenuButton(title: "SETTINGS") {
                        currentScreen = .settings
                    }
                }
                .frame(width: 300)

                Spacer()

                // Footer
                Text("v0.1.0 Pre-Alpha")
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .padding(.top, 80)
            .padding(.bottom, 20)
        }
    }
}

struct MenuButton: View {
    let title: String
    let action: () -> Void

    @State private var isHovering = false

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.custom("Palatino", size: 18))
                .fontWeight(.bold)
                .foregroundColor(isHovering ? .black : .gold)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(
                    ZStack {
                        Color.black.opacity(0.8)

                        // Border
                        RoundedRectangle(cornerRadius: 4)
                            .stroke(Color.gold, lineWidth: 2)

                        if isHovering {
                            Color.gold
                        }
                    }
                )
                .cornerRadius(4)
                .overlay(
                    // Inner bevel effect
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.white.opacity(0.1), lineWidth: 1)
                        .padding(2)
                )
        }
        .buttonStyle(PlainButtonStyle())
        .onHover { hover in
            withAnimation(.easeInOut(duration: 0.15)) {
                isHovering = hover
            }
        }
        .scaleEffect(isHovering ? 1.02 : 1.0)
    }
}
