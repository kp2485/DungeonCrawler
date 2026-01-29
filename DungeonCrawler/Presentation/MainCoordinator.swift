//
//  MainCoordinator.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/29/26.
//

import SwiftUI

enum AppScreen {
    case start
    case game
    case createCharacter
    case assembleParty
    case settings
}

struct MainCoordinator: View {
    @State private var currentScreen: AppScreen = .start

    var body: some View {
        ZStack {
            switch currentScreen {
            case .start:
                StartScreenView(currentScreen: $currentScreen)
                    .transition(.opacity)
            case .game:
                ContentView()
                    .transition(.move(edge: .trailing))
            case .createCharacter:
                PlaceholderView(title: "Create Character", currentScreen: $currentScreen)
            case .assembleParty:
                PlaceholderView(title: "Assemble Party", currentScreen: $currentScreen)
            case .settings:
                PlaceholderView(title: "Settings", currentScreen: $currentScreen)
            }
        }
        .animation(.easeInOut, value: currentScreen)
    }
}

struct PlaceholderView: View {
    let title: String
    @Binding var currentScreen: AppScreen

    var body: some View {
        VStack(spacing: 20) {
            Text(title)
                .font(.largeTitle)
                .foregroundColor(.gold)

            Button("Back") {
                currentScreen = .start
            }
            .buttonStyle(GoldButtonStyle())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black)
    }
}
