//
//  PartyMembers.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 28/06/2025.
//

final class PartyMembers {
    private let members: [PartyMember]

    init() {
        let shuffledCharacters = GreekPantheon.allCharacters.shuffled()
        // Take top 4, or fewer if not enough (unlikely)
        let selected = Array(shuffledCharacters.prefix(4))

        self.members = selected.map { PartyMember(character: $0) }
    }

    subscript(partyPosition: PartyPosition) -> PartyMember {
        switch partyPosition {
        case .frontLeft:
            members[0]
        case .frontRight:
            members[1]
        case .backLeft:
            members[2]
        case .backRight:
            members[3]
        }
    }

    var alivePartyMembers: [PartyMember] {
        members.filter { $0.isAlive }
    }

    var allPartyMembers: [PartyMember] {
        members
    }
}

enum PartyPosition {
    case frontLeft
    case frontRight
    case backLeft
    case backRight
}
