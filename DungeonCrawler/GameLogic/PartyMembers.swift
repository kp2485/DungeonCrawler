//
//  PartyMembers.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 28/06/2025.
//

final class PartyMembers {
    private(set) var members: [PartyMember]
    private(set) var formation: [PartyPosition: PartyMember] = [:]

    // Make init public if needed, or keep internal.
    init() {
        // Default Party Composition
        /*
        1.  **Alexios** (Male Hoplite) - Front Left
        2.  **Thalia** (Female Hunter) - Front Right
        3.  **Nikos** (Male Peltast) - Middle Left
        4.  **Callista** (Female Aoidos) - Middle Right
        5.  **Kyros** (Male Athlete) - Back Left
        6.  **Elias** (Male Philosopher) - Back Right
        */

        let hoplite = Profession.allProfessions.first { $0.name == "Hoplite" }!
        let hunter = Profession.allProfessions.first { $0.name == "Kynegetes" }!
        let peltast = Profession.allProfessions.first { $0.name == "Peltast" }!
        let aoidos = Profession.allProfessions.first { $0.name == "Aoidos" }!
        let athlete = Profession.allProfessions.first { $0.name == "Athlete" }!
        let philosopher = Profession.allProfessions.first { $0.name == "Philosopher" }!

        // Safe fallback attributes (Average 10s)
        let fallbackAttrs = Attributes(
            strength: 10, endurance: 10, agility: 10, speed: 10, intelligence: 10, wisdom: 10,
            dexterity: 10, constitution: 10, perception: 10, luck: 10, willpower: 10)

        // Create characters using the new system (High points for default party to ensure they rock)
        let alexios =
            CharacterCreator.createCharacter(
                name: "Alexios", sex: .male, profession: hoplite, bonusPoints: 40)
            ?? PartyMember(
                name: "Alexios", sex: .male, profession: hoplite, attributes: fallbackAttrs)

        let thalia =
            CharacterCreator.createCharacter(
                name: "Thalia", sex: .female, profession: hunter, bonusPoints: 40)
            ?? PartyMember(
                name: "Thalia", sex: .female, profession: hunter, attributes: fallbackAttrs)

        let nikos =
            CharacterCreator.createCharacter(
                name: "Nikos", sex: .male, profession: peltast, bonusPoints: 40)
            ?? PartyMember(
                name: "Nikos", sex: .male, profession: peltast, attributes: fallbackAttrs)

        let callista =
            CharacterCreator.createCharacter(
                name: "Callista", sex: .female, profession: aoidos, bonusPoints: 40)
            ?? PartyMember(
                name: "Callista", sex: .female, profession: aoidos, attributes: fallbackAttrs)

        let kyros =
            CharacterCreator.createCharacter(
                name: "Kyros", sex: .male, profession: athlete, bonusPoints: 40)
            ?? PartyMember(
                name: "Kyros", sex: .male, profession: athlete, attributes: fallbackAttrs)

        let elias =
            CharacterCreator.createCharacter(
                name: "Elias", sex: .male, profession: philosopher, bonusPoints: 40)
            ?? PartyMember(
                name: "Elias", sex: .male, profession: philosopher, attributes: fallbackAttrs)

        self.members = [alexios, thalia, nikos, callista, kyros, elias]

        // Default Formation
        formation[.frontLeft] = alexios
        formation[.frontRight] = thalia
        formation[.middleLeft] = nikos
        formation[.middleRight] = callista
        formation[.backLeft] = kyros
        formation[.backRight] = elias
    }

    func add(_ member: PartyMember) {
        members.append(member)
        // Auto-assign to empty slot if available?
        // simple logic: fill next available slot
        for position in PartyPosition.allCases {
            if formation[position] == nil {
                formation[position] = member
                break
            }
        }
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
    case middleLeft
    case middleRight
    case backLeft
    case backRight

    var isFrontRow: Bool {
        return self == .frontLeft || self == .frontRight
    }

    var isMiddleRow: Bool {
        return self == .middleLeft || self == .middleRight
    }

    var isBackRow: Bool {
        return self == .backLeft || self == .backRight
    }
}
