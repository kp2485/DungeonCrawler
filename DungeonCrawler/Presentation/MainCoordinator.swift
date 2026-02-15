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
    @StateObject private var viewModel: ViewModel

    init() {
        let world = MainCoordinator.makeInitialWorld()
        _viewModel = StateObject(wrappedValue: ViewModel(world: world))
    }

    var body: some View {
        ZStack {
            switch currentScreen {
            case .start:
                StartScreenView(currentScreen: $currentScreen)
                    .transition(.opacity)
            case .game:
                ContentView(viewModel: viewModel)
                    .transition(.move(edge: .trailing))
            case .createCharacter:
                CharacterCreationView(viewModel: viewModel, currentScreen: $currentScreen)
            case .assembleParty:
                PlaceholderView(title: "Assemble Party", currentScreen: $currentScreen)
            case .settings:
                PlaceholderView(title: "Settings", currentScreen: $currentScreen)
            }
        }
        .animation(.easeInOut, value: currentScreen)
    }

    static func makeInitialWorld() -> World {
        return makeWorld([
            """
            #######
            #S.#.C#
            #....l#
            #e.e..#
            #<#L..#
            #######
            """,
            """
            #######
            #....+#
            #....O#
            #.#...#
            #>#...#
            #.#...#
            #T....#
            #######
            """,
        ])
    }
}

struct PlaceholderView: View {
    let title: String
    @Binding var currentScreen: AppScreen

    var body: some View {
        ZStack {
            StoneBackground()

            VStack(spacing: 20) {
                ZStack {
                    StoneBackground(bevel: false)
                        .frame(height: 60)
                        .overlay(BevelBorder(width: 2))

                    Text(title)
                        .font(.largeTitle)
                        .foregroundColor(.wizGold)
                        .shadow(color: .black, radius: 1)
                }

                RetroButton(label: "BACK") {
                    currentScreen = .start
                }
            }
            .padding()
        }
    }
}
