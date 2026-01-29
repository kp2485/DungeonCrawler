import Foundation

struct MythologicalCharacter: Identifiable {
    let id = UUID()
    let name: String
    let title: String
    let description: String
    let tags: Set<MythologicalCategory>

    // Stats
    let level: Int
    let baseAttributes: Attributes  // Base stats at level 1? Or current stats? Let's assume these are the stats for this character instance.
    // If we want scaling, we might want 'growth' stats, but for now fixed stats per character entry is fine,
    // or we assume the attributes provided ARE the stats for that level.

    let abilities: [Ability]

    // Computed props for scaling if needed
    var maxHP: Int {
        // Simple D&D style: Con mod * level + base?
        // Or just usage of the Attribute directly like current system.
        // Current system: endurance * 2.
        // Let's keep it simple: numeric attributes are the source of truth.
        baseAttributes.endurance * 2 + (level * 5)
    }

    var maxMana: Int {
        baseAttributes.wisdom * 2 + (level * 5)
    }
}
