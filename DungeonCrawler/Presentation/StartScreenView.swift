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
            Color.black.opacity(0.2)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 40) {
                // Title
                ZStack {
                    StoneBackground(bevel: false)
                        .cornerRadius(8)

                    VStack(spacing: 8) {
                        Text("THE LABYRINTH")
                            .font(.system(size: 48, weight: .black, design: .serif))
                            .foregroundColor(.wizGold)
                            .shadow(color: .black, radius: 2, x: 2, y: 2)

                        Text("OF THE PANTHEON")
                            .font(.system(size: 20, weight: .bold, design: .serif))
                            .foregroundColor(.stoneLight)
                            .tracking(4)
                    }
                    .padding(24)
                }
                .frame(maxWidth: 500)
                .fixedSize(horizontal: false, vertical: true)
                .overlay(BevelBorder(width: 4, reversed: false).cornerRadius(8))
                .shadow(color: .black.opacity(0.5), radius: 10, x: 0, y: 10)
                .padding(.bottom, 20)

                // Menu Buttons
                VStack(spacing: 16) {
                    RetroButton(label: "TEST DUNGEON", width: 260) {
                        currentScreen = .game
                    }

                    RetroButton(label: "CREATE CHARACTER", width: 260) {
                        currentScreen = .createCharacter
                    }

                    RetroButton(label: "ASSEMBLE PARTY", width: 260) {
                        currentScreen = .assembleParty
                    }

                    RetroButton(label: "SETTINGS", width: 260) {
                        currentScreen = .settings
                    }
                }
                .frame(width: 260)

                Spacer()

                // Footer
                Text("v0.1.0 Pre-Alpha")
                    .font(.caption)
                    .foregroundColor(.stoneMid)
            }
            .padding(.top, 80)
            .padding(.bottom, 20)
        }
    }
}
