//
//  Styles.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/29/26.
//

import SwiftUI

// MARK: - Colors
extension Color {
    // Wizardry 7 Palette
    static let gold = Color(red: 0.85, green: 0.75, blue: 0.25)
    static let wizRed = Color(red: 0.8, green: 0.1, blue: 0.1)  // HP
    static let wizBlue = Color(red: 0.1, green: 0.2, blue: 0.8)  // MP
    static let wizYellow = Color(red: 0.9, green: 0.8, blue: 0.1)  // Stamina
    static let wizGray = Color(red: 0.3, green: 0.3, blue: 0.35)  // Stone
    static let wizDarkGray = Color(red: 0.15, green: 0.15, blue: 0.18)  // Deep Stone
}

// MARK: - Components
struct StoneBackground: View {
    var body: some View {
        ZStack {
            Color.wizDarkGray

            // Texture noise (simulated)
            Rectangle()
                .fill(Color.wizGray.opacity(0.1))
                .mask(
                    Image(systemName: "square.fill")
                        .resizable()
                )

            // Inner bevel/border
            RoundedRectangle(cornerRadius: 2)
                .strokeBorder(
                    LinearGradient(
                        gradient: Gradient(colors: [.white.opacity(0.1), .black.opacity(0.3)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    lineWidth: 2
                )
        }
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
