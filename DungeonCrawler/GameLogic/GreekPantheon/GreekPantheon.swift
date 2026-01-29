import Foundation

struct GreekPantheon {
    // Aggregates all encyclopedias
    static var allCharacters: [MythologicalCharacter] {
        return EncyclopediaA.characters
        // + EncyclopediaB.characters ... when added
    }

    // Helper to find by tag
    static func characters(with tag: MythologicalCategory) -> [MythologicalCharacter] {
        allCharacters.filter { $0.tags.contains(tag) }
    }
}
