import Foundation

struct MythologicalCharacter {
    let name: String
    let title: String
    let baseAttributes: Attributes
}

struct GreekPantheon {
    static let allCharacters: [MythologicalCharacter] = [
        // MARK: - Olympians
        MythologicalCharacter(
            name: "Zeus", title: "King of Gods",
            baseAttributes: Attributes(
                strength: 16, endurance: 14, agility: 10, speed: 12, intelligence: 14, wisdom: 18,
                dexterity: 12, constitution: 14, perception: 16, luck: 12, willpower: 18)),
        MythologicalCharacter(
            name: "Hera", title: "Queen of Gods",
            baseAttributes: Attributes(
                strength: 10, endurance: 14, agility: 10, speed: 10, intelligence: 16, wisdom: 16,
                dexterity: 10, constitution: 14, perception: 16, luck: 12, willpower: 18)),
        MythologicalCharacter(
            name: "Poseidon", title: "God of the Sea",
            baseAttributes: Attributes(
                strength: 17, endurance: 16, agility: 10, speed: 10, intelligence: 12, wisdom: 14,
                dexterity: 10, constitution: 16, perception: 12, luck: 10, willpower: 16)),
        MythologicalCharacter(
            name: "Demeter", title: "Goddess of Harvest",
            baseAttributes: Attributes(
                strength: 12, endurance: 18, agility: 8, speed: 8, intelligence: 14, wisdom: 16,
                dexterity: 8, constitution: 18, perception: 12, luck: 10, willpower: 14)),
        MythologicalCharacter(
            name: "Ares", title: "God of War",
            baseAttributes: Attributes(
                strength: 18, endurance: 16, agility: 14, speed: 14, intelligence: 8, wisdom: 8,
                dexterity: 16, constitution: 16, perception: 12, luck: 10, willpower: 12)),
        MythologicalCharacter(
            name: "Athena", title: "Goddess of Wisdom",
            baseAttributes: Attributes(
                strength: 14, endurance: 12, agility: 14, speed: 12, intelligence: 18, wisdom: 18,
                dexterity: 14, constitution: 12, perception: 16, luck: 10, willpower: 16)),
        MythologicalCharacter(
            name: "Apollo", title: "God of the Sun",
            baseAttributes: Attributes(
                strength: 14, endurance: 12, agility: 16, speed: 14, intelligence: 14, wisdom: 14,
                dexterity: 18, constitution: 12, perception: 18, luck: 12, willpower: 12)),
        MythologicalCharacter(
            name: "Artemis", title: "Goddess of the Hunt",
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 18, speed: 16, intelligence: 14, wisdom: 16,
                dexterity: 18, constitution: 12, perception: 18, luck: 10, willpower: 14)),
        MythologicalCharacter(
            name: "Hephaestus", title: "God of the Forge",
            baseAttributes: Attributes(
                strength: 16, endurance: 18, agility: 8, speed: 8, intelligence: 16, wisdom: 14,
                dexterity: 14, constitution: 18, perception: 10, luck: 10, willpower: 16)),
        MythologicalCharacter(
            name: "Aphrodite", title: "Goddess of Love",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 10, intelligence: 14, wisdom: 12,
                dexterity: 10, constitution: 10, perception: 14, luck: 18, willpower: 16)),
        MythologicalCharacter(
            name: "Hermes", title: "Messenger God",
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 18, speed: 18, intelligence: 16, wisdom: 14,
                dexterity: 16, constitution: 10, perception: 14, luck: 14, willpower: 10)),
        MythologicalCharacter(
            name: "Dionysus", title: "God of Wine",
            baseAttributes: Attributes(
                strength: 10, endurance: 14, agility: 12, speed: 10, intelligence: 14, wisdom: 12,
                dexterity: 10, constitution: 16, perception: 10, luck: 18, willpower: 14)),

        // MARK: - Major Deities & Titans
        MythologicalCharacter(
            name: "Hades", title: "King of the Underworld",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 10, speed: 10, intelligence: 16, wisdom: 16,
                dexterity: 10, constitution: 14, perception: 12, luck: 8, willpower: 18)),
        MythologicalCharacter(
            name: "Hestia", title: "Goddess of the Hearth",
            baseAttributes: Attributes(
                strength: 10, endurance: 16, agility: 8, speed: 8, intelligence: 12, wisdom: 18,
                dexterity: 8, constitution: 16, perception: 10, luck: 12, willpower: 18)),
        MythologicalCharacter(
            name: "Persephone", title: "Queen of the Underworld",
            baseAttributes: Attributes(
                strength: 8, endurance: 12, agility: 10, speed: 10, intelligence: 14, wisdom: 14,
                dexterity: 8, constitution: 12, perception: 12, luck: 14, willpower: 16)),
        MythologicalCharacter(
            name: "Eros", title: "God of Desire",
            baseAttributes: Attributes(
                strength: 10, endurance: 10, agility: 16, speed: 16, intelligence: 12, wisdom: 10,
                dexterity: 16, constitution: 10, perception: 14, luck: 16, willpower: 10)),
        MythologicalCharacter(
            name: "Pan", title: "God of the Wild",
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 16, speed: 14, intelligence: 10, wisdom: 16,
                dexterity: 14, constitution: 14, perception: 16, luck: 14, willpower: 10)),
        MythologicalCharacter(
            name: "Nike", title: "Goddess of Victory",
            baseAttributes: Attributes(
                strength: 14, endurance: 12, agility: 16, speed: 16, intelligence: 12, wisdom: 12,
                dexterity: 14, constitution: 12, perception: 14, luck: 18, willpower: 14)),
        MythologicalCharacter(
            name: "Hebe", title: "Goddess of Youth",
            baseAttributes: Attributes(
                strength: 8, endurance: 18, agility: 14, speed: 12, intelligence: 10, wisdom: 10,
                dexterity: 10, constitution: 18, perception: 10, luck: 14, willpower: 10)),
        MythologicalCharacter(
            name: "Asclepius", title: "God of Medicine",
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 10, speed: 10, intelligence: 18, wisdom: 18,
                dexterity: 14, constitution: 12, perception: 16, luck: 10, willpower: 14)),
        MythologicalCharacter(
            name: "Helios", title: "Titan of the Sun",
            baseAttributes: Attributes(
                strength: 16, endurance: 14, agility: 12, speed: 12, intelligence: 14, wisdom: 14,
                dexterity: 12, constitution: 16, perception: 18, luck: 10, willpower: 14)),
        MythologicalCharacter(
            name: "Selene", title: "Titan of the Moon",
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 12, speed: 12, intelligence: 14, wisdom: 16,
                dexterity: 10, constitution: 12, perception: 18, luck: 12, willpower: 14)),
        MythologicalCharacter(
            name: "Eos", title: "Titan of the Dawn",
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 12, perception: 16, luck: 14, willpower: 12)),
        MythologicalCharacter(
            name: "Hecate", title: "Goddess of Magic",
            baseAttributes: Attributes(
                strength: 8, endurance: 12, agility: 10, speed: 10, intelligence: 18, wisdom: 18,
                dexterity: 10, constitution: 10, perception: 16, luck: 12, willpower: 18)),
        MythologicalCharacter(
            name: "Tyche", title: "Goddess of Fortune",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 12, intelligence: 10, wisdom: 10,
                dexterity: 10, constitution: 10, perception: 10, luck: 20, willpower: 10)),
        MythologicalCharacter(
            name: "Nemesis", title: "Goddess of Retribution",
            baseAttributes: Attributes(
                strength: 12, endurance: 12, agility: 12, speed: 12, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 12, perception: 16, luck: 8, willpower: 16)),
        MythologicalCharacter(
            name: "Hypnos", title: "God of Sleep",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 8, speed: 8, intelligence: 14, wisdom: 14,
                dexterity: 8, constitution: 10, perception: 12, luck: 10, willpower: 18)),
        MythologicalCharacter(
            name: "Thanatos", title: "God of Death",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 16, wisdom: 16,
                dexterity: 12, constitution: 14, perception: 14, luck: 6, willpower: 18)),
        MythologicalCharacter(
            name: "Prometheus", title: "Titan of Fire",
            baseAttributes: Attributes(
                strength: 14, endurance: 18, agility: 10, speed: 10, intelligence: 18, wisdom: 16,
                dexterity: 10, constitution: 18, perception: 14, luck: 10, willpower: 18)),

        // MARK: - Heroes
        MythologicalCharacter(
            name: "Hercules", title: "Son of Zeus",
            baseAttributes: Attributes(
                strength: 20, endurance: 18, agility: 10, speed: 10, intelligence: 10, wisdom: 10,
                dexterity: 12, constitution: 18, perception: 10, luck: 10, willpower: 16)),
        MythologicalCharacter(
            name: "Achilles", title: "Hero of Troy",
            baseAttributes: Attributes(
                strength: 18, endurance: 16, agility: 16, speed: 14, intelligence: 12, wisdom: 10,
                dexterity: 16, constitution: 16, perception: 14, luck: 8, willpower: 14)),
        MythologicalCharacter(
            name: "Odysseus", title: "King of Ithaca",
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 12, speed: 12, intelligence: 18, wisdom: 16,
                dexterity: 14, constitution: 14, perception: 16, luck: 14, willpower: 18)),
        MythologicalCharacter(
            name: "Perseus", title: "Slayer of Gorgons",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 14, constitution: 12, perception: 12, luck: 16, willpower: 14)),
        MythologicalCharacter(
            name: "Theseus", title: "Slayer of Minotaurs",
            baseAttributes: Attributes(
                strength: 16, endurance: 14, agility: 14, speed: 12, intelligence: 14, wisdom: 12,
                dexterity: 12, constitution: 14, perception: 12, luck: 12, willpower: 14)),
        MythologicalCharacter(
            name: "Jason", title: "Leader of Argonauts",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 14, perception: 12, luck: 14, willpower: 14)),
        MythologicalCharacter(
            name: "Atalanta", title: "Swift Huntress",
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 18, speed: 18, intelligence: 12, wisdom: 12,
                dexterity: 16, constitution: 12, perception: 16, luck: 12, willpower: 12)),
        MythologicalCharacter(
            name: "Orpheus", title: "Legendary Musician",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 12, intelligence: 14, wisdom: 12,
                dexterity: 14, constitution: 10, perception: 14, luck: 12, willpower: 18)),
        MythologicalCharacter(
            name: "Bellerophon", title: "Slayer of Chimera",
            baseAttributes: Attributes(
                strength: 14, endurance: 12, agility: 14, speed: 14, intelligence: 10, wisdom: 10,
                dexterity: 14, constitution: 12, perception: 12, luck: 14, willpower: 12)),
        MythologicalCharacter(
            name: "Cadmus", title: "Founder of Thebes",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 14, wisdom: 14,
                dexterity: 12, constitution: 14, perception: 12, luck: 12, willpower: 14)),
        MythologicalCharacter(
            name: "Hector", title: "Prince of Troy",
            baseAttributes: Attributes(
                strength: 16, endurance: 16, agility: 12, speed: 12, intelligence: 14, wisdom: 12,
                dexterity: 14, constitution: 16, perception: 12, luck: 8, willpower: 16)),
        MythologicalCharacter(
            name: "Paris", title: "Prince of Troy",
            baseAttributes: Attributes(
                strength: 10, endurance: 10, agility: 12, speed: 12, intelligence: 10, wisdom: 8,
                dexterity: 18, constitution: 10, perception: 12, luck: 14, willpower: 8)),
        MythologicalCharacter(
            name: "Aeneas", title: "Trojan Hero",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 12, wisdom: 14,
                dexterity: 12, constitution: 14, perception: 12, luck: 14, willpower: 16)),
        MythologicalCharacter(
            name: "Castor", title: "Twin of Pollux",
            baseAttributes: Attributes(
                strength: 14, endurance: 12, agility: 14, speed: 14, intelligence: 10, wisdom: 10,
                dexterity: 14, constitution: 12, perception: 12, luck: 12, willpower: 12)),
        MythologicalCharacter(
            name: "Pollux", title: "Twin of Castor",
            baseAttributes: Attributes(
                strength: 16, endurance: 14, agility: 12, speed: 12, intelligence: 10, wisdom: 10,
                dexterity: 12, constitution: 14, perception: 12, luck: 12, willpower: 12)),
        MythologicalCharacter(
            name: "Hippolyta", title: "Amazon Queen",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 16, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 16, constitution: 14, perception: 14, luck: 10, willpower: 14)),
        MythologicalCharacter(
            name: "Penthesilea", title: "Amazon Warrior",
            baseAttributes: Attributes(
                strength: 16, endurance: 14, agility: 16, speed: 16, intelligence: 10, wisdom: 10,
                dexterity: 16, constitution: 14, perception: 12, luck: 10, willpower: 14)),
        MythologicalCharacter(
            name: "Ajax (Great)", title: "Tower of Power",
            baseAttributes: Attributes(
                strength: 18, endurance: 18, agility: 8, speed: 8, intelligence: 10, wisdom: 8,
                dexterity: 10, constitution: 18, perception: 10, luck: 10, willpower: 14)),
        MythologicalCharacter(
            name: "Diomedes", title: "Favorite of Athena",
            baseAttributes: Attributes(
                strength: 16, endurance: 16, agility: 14, speed: 14, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 16, perception: 14, luck: 12, willpower: 14)),
        MythologicalCharacter(
            name: "Patroclus", title: "Companion of Achilles",
            baseAttributes: Attributes(
                strength: 12, endurance: 12, agility: 12, speed: 12, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 12, perception: 12, luck: 10, willpower: 12)),

        // MARK: - Major Figures
        MythologicalCharacter(
            name: "Chiron", title: "Trainer of Heroes",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 18, wisdom: 20,
                dexterity: 12, constitution: 14, perception: 16, luck: 12, willpower: 16)),
        MythologicalCharacter(
            name: "Medea", title: "Colchian Sorceress",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 10, speed: 10, intelligence: 18, wisdom: 16,
                dexterity: 10, constitution: 10, perception: 14, luck: 10, willpower: 16)),
        MythologicalCharacter(
            name: "Circe", title: "Enchantress of Aeaea",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 10, speed: 10, intelligence: 18, wisdom: 18,
                dexterity: 10, constitution: 10, perception: 14, luck: 12, willpower: 16)),
        MythologicalCharacter(
            name: "Pandora", title: "Bearer of the Box",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 12, intelligence: 14, wisdom: 8,
                dexterity: 12, constitution: 10, perception: 14, luck: 6, willpower: 8)),
    ]
}
