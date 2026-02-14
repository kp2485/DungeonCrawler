//
//  Styles.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/29/26.
//

import SwiftUI

// MARK: - Colors
extension Color {
    // Retro RPG Palette
    static let wizGold = Color(red: 0.95, green: 0.85, blue: 0.35)
    static let wizDarkGold = Color(red: 0.6, green: 0.5, blue: 0.1)

    static let wizRed = Color(red: 0.85, green: 0.15, blue: 0.15)  // HP
    static let wizBlue = Color(red: 0.2, green: 0.4, blue: 0.9)  // MP
    static let wizGreen = Color(red: 0.2, green: 0.7, blue: 0.2)  // Stamina/Good

    // Stone UI Colors
    static let stoneLight = Color(red: 0.55, green: 0.55, blue: 0.60)
    static let stoneMid = Color(red: 0.40, green: 0.40, blue: 0.45)
    static let stoneDark = Color(red: 0.25, green: 0.25, blue: 0.30)
    static let stoneShadow = Color(red: 0.15, green: 0.15, blue: 0.20)
}

// MARK: - View Modifiers

struct InnerShadow: ViewModifier {
    var radius: CGFloat = 4

    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.black.opacity(0.6), lineWidth: radius)
                    .blur(radius: radius / 2)
                    .mask(
                        RoundedRectangle(cornerRadius: 2)
                            .fill(
                                LinearGradient(
                                    colors: [.black, .clear], startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 2)
                    .stroke(Color.white.opacity(0.1), lineWidth: 1)
            )
    }
}

extension View {
    func innerShadow(radius: CGFloat = 4) -> some View {
        self.modifier(InnerShadow(radius: radius))
    }
}

// MARK: - UI Components

struct StoneBackground: View {
    var bevel: Bool = true

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Base Stone Color
                Color.stoneMid

                // Texture Noise (Simulated)
                Rectangle()
                    .fill(Color.stoneLight.opacity(0.05))
                    .frame(width: 2, height: 2)
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .background(Color.stoneDark)
                    .opacity(0.2)

                // Gradient Glare for 3D effect
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color.white.opacity(0.05),
                        Color.clear,
                        Color.black.opacity(0.2),
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )

                // Bevel Border
                if bevel {
                    BevelBorder()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct BevelBorder: View {
    var width: CGFloat = 3
    var reversed: Bool = false

    var body: some View {
        GeometryReader { geo in
            ZStack {
                // Top/Left Light
                Path { path in
                    path.move(to: CGPoint(x: 0, y: geo.size.height))
                    path.addLine(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: geo.size.width, y: 0))
                    path.addLine(to: CGPoint(x: geo.size.width - width, y: width))
                    path.addLine(to: CGPoint(x: width, y: width))
                    path.addLine(to: CGPoint(x: width, y: geo.size.height - width))
                    path.closeSubpath()
                }
                .fill(reversed ? Color.stoneShadow : Color.stoneLight)

                // Bottom/Right Dark
                Path { path in
                    path.move(to: CGPoint(x: 0, y: geo.size.height))
                    path.addLine(to: CGPoint(x: geo.size.width, y: geo.size.height))
                    path.addLine(to: CGPoint(x: geo.size.width, y: 0))
                    path.addLine(to: CGPoint(x: geo.size.width - width, y: width))
                    path.addLine(to: CGPoint(x: geo.size.width - width, y: geo.size.height - width))
                    path.addLine(to: CGPoint(x: width, y: geo.size.height - width))
                    path.closeSubpath()
                }
                .fill(reversed ? Color.stoneLight : Color.stoneShadow)
            }
        }
    }
}

struct InsetPanel<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(4)
            .background(Color.black)
            .overlay(
                BevelBorder(width: 2, reversed: true)
            )
    }
}

struct RetroButton: View {
    let label: String
    var small: Bool = false
    var width: CGFloat? = nil
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                // Button Face
                LinearGradient(
                    colors: [Color.stoneLight, Color.stoneMid],
                    startPoint: .top,
                    endPoint: .bottom
                )

                // Text
                Text(label)
                    .font(.system(size: small ? 10 : 12, weight: .bold, design: .monospaced))
                    .foregroundColor(.wizGold)
                    .shadow(color: .black, radius: 1, x: 1, y: 1)

                // Bevel
                BevelBorder(width: 2, reversed: false)
            }
            .frame(width: width ?? (small ? 30 : 64), height: small ? 20 : 28)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
