//
//  CharacterCreationView.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/29/26.
//

import SwiftUI

struct CharacterCreationView: View {
    @ObservedObject var viewModel: ViewModel
    @Binding var currentScreen: AppScreen

    // Form State
    @State private var name: String = ""
    @State private var selectedSex: Sex = .male
    @State private var selectedProfession: Profession?
    @State private var bonusPoints: Int?

    // UI Feedback
    @State private var errorMessage: String?

    var body: some View {
        ZStack {
            StoneBackground()

            VStack(spacing: 20) {
                // Header
                ZStack {
                    StoneBackground(bevel: false)
                        .frame(height: 80)

                    Text("CREATE CHARACTER")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.wizGold)
                        .shadow(color: .black, radius: 2)
                        .padding(.top, 20)
                }
                .overlay(BevelBorder(width: 3, reversed: false))
                .edgesIgnoringSafeArea(.top)

                // Main Form
                HStack(alignment: .top, spacing: 20) {

                    // LEFT COLUMN: Inputs
                    VStack(alignment: .leading, spacing: 20) {

                        // Name Input
                        VStack(alignment: .leading, spacing: 4) {
                            Text("NAME")
                                .font(.caption)
                                .foregroundColor(.stoneLight)

                            InsetPanel {
                                TextField("Enter Name", text: $name)
                                    .textFieldStyle(PlainTextFieldStyle())
                                    .padding(8)
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, design: .monospaced))
                            }
                        }

                        // Sex Selection
                        VStack(alignment: .leading, spacing: 4) {
                            Text("SEX")
                                .font(.caption)
                                .foregroundColor(.stoneLight)

                            HStack {
                                SexButton(sex: .male, selected: $selectedSex)
                                SexButton(sex: .female, selected: $selectedSex)
                            }
                        }

                        // Bonus Points
                        VStack(alignment: .leading, spacing: 4) {
                            Text("BONUS POINTS")
                                .font(.caption)
                                .foregroundColor(.stoneLight)

                            HStack {
                                InsetPanel {
                                    if let points = bonusPoints {
                                        Text("\(points)")
                                            .font(
                                                .system(
                                                    size: 32, weight: .bold, design: .monospaced)
                                            )
                                            .foregroundColor(.wizGreen)
                                            .frame(width: 80, height: 40)
                                    } else {
                                        Text("??")
                                            .font(
                                                .system(
                                                    size: 32, weight: .bold, design: .monospaced)
                                            )
                                            .foregroundColor(.gray)
                                            .frame(width: 80, height: 40)
                                    }
                                }

                                RetroButton(label: "ROLL") {
                                    bonusPoints = CharacterCreator.rollBonusPoints()
                                }
                            }
                        }
                    }
                    .frame(width: 300)

                    // RIGHT COLUMN: Profession Selection
                    VStack(alignment: .leading, spacing: 4) {
                        Text("PROFESSION")
                            .font(.caption)
                            .foregroundColor(.stoneLight)

                        InsetPanel {
                            ScrollView {
                                VStack(spacing: 2) {
                                    ForEach(Profession.allProfessions, id: \.name) { profession in
                                        ProfessionButton(
                                            profession: profession,
                                            selected: $selectedProfession,
                                            bonusPoints: bonusPoints
                                        )
                                    }
                                }
                                .padding(2)
                            }
                            .frame(width: 300, height: 300)
                        }
                    }
                }
                .padding()

                // Error Message
                if let error = errorMessage {
                    Text(error)
                        .foregroundColor(.wizRed)
                        .font(.custom("Courier", size: 16))
                        .shadow(color: .black, radius: 1)
                }

                Spacer()

                // Footer Actions
                HStack(spacing: 40) {
                    RetroButton(label: "CANCEL") {
                        currentScreen = .start
                    }

                    RetroButton(label: "CREATE") {
                        createCharacter()
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }

    private func createCharacter() {
        guard !name.isEmpty else {
            errorMessage = "Name is required."
            return
        }
        guard let profession = selectedProfession else {
            errorMessage = "Select a profession."
            return
        }
        guard let points = bonusPoints else {
            errorMessage = "Roll for bonus points!"
            return
        }

        // Attempt Creation
        if let newMember = CharacterCreator.createCharacter(
            name: name,
            sex: selectedSex,
            profession: profession,
            bonusPoints: points
        ) {
            // Success!
            viewModel.world.partyMembers.add(newMember)
            print("Created \(newMember.name)!")
            currentScreen = .start  // Or to Party Assembly? Return to start for prototype.
        } else {
            errorMessage = "Not enough points for \(profession.name)!"
        }
    }
}

// MARK: - Subcomponents

struct SexButton: View {
    let sex: Sex
    @Binding var selected: Sex

    var body: some View {
        Button(action: { selected = sex }) {
            ZStack {
                // Background
                if selected == sex {
                    Color.stoneDark
                } else {
                    Color.stoneMid.opacity(0.5)
                }

                Text(sex.rawValue.uppercased())
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundColor(selected == sex ? .wizGold : .stoneLight)

                BevelBorder(width: 2, reversed: selected == sex)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 30)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct ProfessionButton: View {
    let profession: Profession
    @Binding var selected: Profession?
    let bonusPoints: Int?

    var body: some View {
        Button(action: { selected = profession }) {
            HStack {
                Text(profession.name)
                    .font(.system(size: 14, weight: .bold, design: .monospaced))
                    .foregroundColor(selected?.name == profession.name ? .wizGold : .stoneLight)
                Spacer()
            }
            .padding(8)
            .background(
                selected?.name == profession.name ? Color.stoneDark : Color.clear)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
