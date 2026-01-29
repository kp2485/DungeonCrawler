//
//  PartyMembers.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 28/06/2025.
//

final class PartyMembers {
    private let members: [PartyMember]
    private(set) var formation: [PartyPosition: PartyMember] = [:]

    init() {
        let shuffledCharacters = GreekPantheon.allCharacters.shuffled()
        // Take top 4, or fewer if not enough (unlikely)
        let selected = Array(shuffledCharacters.prefix(4))

        self.members = selected.map { PartyMember(character: $0) }

        // Default Formation
        if members.count > 0 { formation[.frontLeft] = members[0] }
        if members.count > 1 { formation[.frontRight] = members[1] }
        if members.count > 2 { formation[.backLeft] = members[2] }
        if members.count > 3 { formation[.backRight] = members[3] }
    }

    subscript(partyPosition: PartyPosition) -> PartyMember? {
        return formation[partyPosition]
    }

    // Legacy support for array access if needed, but formation is source of truth for combat positions
    var alivePartyMembers: [PartyMember] {
        members.filter { $0.isAlive }
    }

    var allPartyMembers: [PartyMember] {
        members
    }
}

enum PartyPosition: String, CaseIterable, Codable {
    case frontLeft
    case frontRight
    case backLeft
    case backRight

    var isFrontRow: Bool {
        return self == .frontLeft || self == .frontRight
    }
}
