//
//  Styles.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/29/26.
//

import SwiftUI

// MARK: - Colors
extension Color {
    static let gold = Color(red: 0.8, green: 0.7, blue: 0.2)
}

// MARK: - Components
struct StoneBackground: View {
    var body: some View {
        Color(white: 0.2)
            .overlay(
                Image(systemName: "square.fill")  // Placeholder for texture
                    .resizable()
                    .opacity(0.1)
                    .foregroundColor(.black)
            )
        // In a real app we'd use a tiled stone image asset
    }
}

struct GoldButton: View {
    let label: String
    var small: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                Rectangle()
                    .fill(Color.gold)
                    .overlay(
                        Rectangle()
                            .stroke(Color.white.opacity(0.5), lineWidth: 2)
                    )
                    .shadow(radius: 1, y: 1)

                Text(label)
                    .font(.system(size: small ? 12 : 14, weight: .bold, design: .monospaced))
                    .foregroundColor(.black)
            }
            .frame(width: small ? 40 : 80, height: small ? 30 : 30)
        }
    }
}

struct GoldButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color.gold)
            .foregroundColor(.black)
            .cornerRadius(4)
            .overlay(
                RoundedRectangle(cornerRadius: 4)
                    .stroke(Color.white.opacity(0.5), lineWidth: 2)
            )
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
