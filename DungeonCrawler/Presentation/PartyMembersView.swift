//
//  PartyMembersView.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 28/06/2025.
//

import SwiftUI

struct PartyMembersView: View {
    let partyStats: PartyStats

    var body: some View {
        VStack {
            HStack {
                PartyMemberCard(stats: partyStats[.frontLeft])
                PartyMemberCard(stats: partyStats[.frontRight])
            }
            HStack {
                PartyMemberCard(stats: partyStats[.backLeft])
                PartyMemberCard(stats: partyStats[.backRight])
            }
        }
        .font(.headline)
        .foregroundStyle(.white)
        .background(Color.gray)
        .padding()
    }
}

struct PartyMemberCard: View {
    let stats: PartyMemberStats

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(stats.name)
                .font(.headline)
            Text(stats.title)
                .font(.caption)
                .italic()

            HStack {
                Text("HP: \(stats.currentHP)/\(stats.maxHP)")
                    .foregroundColor(stats.currentHP < stats.maxHP / 3 ? .red : .green)
                Spacer()
                Text("MP: \(stats.currentMana)/\(stats.maxMana)")
                    .foregroundColor(.blue)
            }
            .font(.caption)
        }
        .padding(8)
        .background(Color.black.opacity(0.3))
        .cornerRadius(8)
        .frame(minWidth: 150)
    }
}

#Preview {
    PartyMembersView(partyStats: PartyStats(partyMembers: PartyMembers()))
}
