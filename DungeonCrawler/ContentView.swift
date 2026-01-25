//
//  ContentView.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/24/26.
//

import SwiftUI
import RealityKit

struct ContentView: View {
    let world = World()
    
    var body: some View {
        ZStack {
            GameView(world: world)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button("⤵️") {
                        print("Turning left")
                    }
                    Button("⬆️") {
                        world.moveForward()
                    }
                    Button("⤵️") {
                        print("Turning right")
                    }
                }
                HStack {
                    Spacer()
                    Button("⬅️") {
                        print("Moving left")
                    }
                    Button("⬇️") {
                        world.moveBackward()
                    }
                    Button("➡️") {
                        print("Moving right")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
