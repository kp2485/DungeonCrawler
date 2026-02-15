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
        let world = makeWorld([
            """
            ###########
            #S........#
            #.........#
            #...#L#...#
            #...#C#...#
            #...#.#...#
            #...#.#...#
            ###########
            """
        ])

        // Setup Key and Lock logic
        // Chest at (5, 4) characters are 0-indexed from bottom-left?
        // Wait, map parser `toCharacterMatrix` reads lines.
        // Row 0 is the first string? No, typically `y=0` is bottom.
        // Let's check Map init.
        // Row 0 is first string in array?

        /*
        Map.swift:
        for row in 0..<mapArray.count {
            for column in 0..<mapArray[0].count {
                let char = mapArray[row][column]
                let coord = Coordinate(x: column, y: row)
        
        So y=0 is the TOP row if we iterate 0..<count.
        Let's assume row 0 is top.
        
        Map string:
        0: ###########
        1: #S........#
        2: #.........#
        3: #...###...#
        4: #...#C#...#
        5: #...#L#...#
        6: #...#.#...#
        7: ###########
        
        Chest 'C' is at x=5, y=4
        Door 'L' is at x=5, y=5
        
        */

        var floor = world.floors[0]
        let chestCoord = Coordinate(x: 5, y: 4)
        let doorCoord = Coordinate(x: 5, y: 5)
        let keyId = 123

        // 1. Put Key in Chest
        if var chest = floor.objects[chestCoord] {
            let keyItem = Item(
                id: UUID(), name: "Gold Key", description: "A shiny golden key.", type: .key,
                power: 0, keyId: keyId)
            chest.content = [keyItem]
            floor.objects[chestCoord] = chest
        }

        // 2. Lock Door with Key
        if var door = floor.objects[doorCoord] {
            door.state = .door(.locked(difficulty: 99, keyId: keyId))
            floor.objects[doorCoord] = door
        }

        world.floors[0] = floor

        return world
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
