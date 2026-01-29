import Foundation

extension EncyclopediaA {
    static let part2: [MythologicalCharacter] = [
        // 45. Alala
        MythologicalCharacter(
            name: "Alala", title: "War Cry",
            description: "The female personification of the war-cry.",
            tags: [.daemon, .personification], level: 12,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 14, speed: 14, intelligence: 10, wisdom: 10,
                dexterity: 14, constitution: 14, perception: 14, luck: 10, willpower: 16),
            abilities: [.piercingScream]),
        // 46. Alastor
        MythologicalCharacter(
            name: "Alastor", title: "Avenger",
            description: "The daemon of the curse of the blood feud.",
            tags: [.daemon, .underworld], level: 14,
            baseAttributes: Attributes(
                strength: 14, endurance: 16, agility: 14, speed: 14, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 16, perception: 18, luck: 10, willpower: 18),
            abilities: [.bloodFeud]),
        // 47. Alce
        MythologicalCharacter(
            name: "Alce", title: "Battle Strength",
            description: "The female personification of battle-strength and prowess.",
            tags: [.daemon], level: 10,
            baseAttributes: Attributes(
                strength: 16, endurance: 14, agility: 12, speed: 12, intelligence: 10, wisdom: 12,
                dexterity: 12, constitution: 14, perception: 12, luck: 12, willpower: 14),
            abilities: [.battleProwess]),
        // 48. Alcon
        MythologicalCharacter(
            name: "Alcon", title: "Archer Hero",
            description: "A famous archer who could shoot a ring off a serpent's head.",
            tags: [.hero], level: 12,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 18, speed: 16, intelligence: 12, wisdom: 12,
                dexterity: 20, constitution: 14, perception: 20, luck: 14, willpower: 14),
            abilities: [.snakeShot]),
        // 49. Alcyone
        MythologicalCharacter(
            name: "Alcyone", title: "Pleiad Star",
            description: "One of the Pleiad star-nymphs loved by Poseidon.", tags: [.star, .nymph],
            level: 10,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 10, perception: 16, luck: 14, willpower: 12),
            abilities: [.halcyonDays]),
        // 50. Alcyoneus
        MythologicalCharacter(
            name: "Alcyoneus", title: "Immortal Giant",
            description: "The strongest of the Gigantes, immortal within his homeland of Pallene.",
            tags: [.giant], level: 16,
            baseAttributes: Attributes(
                strength: 25, endurance: 25, agility: 10, speed: 10, intelligence: 12, wisdom: 10,
                dexterity: 10, constitution: 25, perception: 12, luck: 8, willpower: 20),
            abilities: [.palleneImmortality, .rockThrow]),
        // 51. Alcyonides
        MythologicalCharacter(
            name: "Alcyonides", title: "Kingfisher Nymphs",
            description: "Daughters of the giant Alcyoneus transformed into kingfishers.",
            tags: [.nymph, .bestiary], level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 8, agility: 16, speed: 16, intelligence: 10, wisdom: 10,
                dexterity: 14, constitution: 8, perception: 16, luck: 12, willpower: 10),
            abilities: [.seaDive]),
        // 52. Alecto
        MythologicalCharacter(
            name: "Alecto", title: "Erinys of Anger",
            description: "One of the three Erinyes (Furies).", tags: [.underworld, .daemon],
            level: 17,
            baseAttributes: Attributes(
                strength: 18, endurance: 20, agility: 18, speed: 18, intelligence: 16, wisdom: 14,
                dexterity: 18, constitution: 20, perception: 20, luck: 10, willpower: 22),
            abilities: [.unceasingAnger]),
        // 53. Aletheia
        MythologicalCharacter(
            name: "Aletheia", title: "Truth", description: "The female personification of truth.",
            tags: [.personification], level: 12,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 12, speed: 12, intelligence: 18, wisdom: 20,
                dexterity: 12, constitution: 12, perception: 22, luck: 14, willpower: 18),
            abilities: [.revealTruth]),
        // 54. Alexiares
        MythologicalCharacter(
            name: "Alexiares", title: "Warding War",
            description: "Immortal son of Heracles and Hebe who wards off war.",
            tags: [.deified, .hero], level: 15,
            baseAttributes: Attributes(
                strength: 18, endurance: 18, agility: 14, speed: 14, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 18, perception: 16, luck: 14, willpower: 16),
            abilities: [.wardOffWar]),
        // 55. Alexiroe
        MythologicalCharacter(
            name: "Alexiroe", title: "Naiad Nymph",
            description: "A Naiad daughter of the river Grenicus.", tags: [.nymph, .river],
            level: 6,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 10, wisdom: 10,
                dexterity: 12, constitution: 10, perception: 12, luck: 12, willpower: 10),
            abilities: [.heal]),
        // 56. Algea
        MythologicalCharacter(
            name: "Algea", title: "Sorrows", description: "The female personifications of sorrow.",
            tags: [.daemon, .personification], level: 8,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 10, speed: 10, intelligence: 12, wisdom: 14,
                dexterity: 10, constitution: 10, perception: 14, luck: 8, willpower: 12),
            abilities: [.tearsOfGrief]),
        // 57. Aloadae
        MythologicalCharacter(
            name: "Aloadae", title: "Poseidon's Giants",
            description: "Two gigantic sons of Poseidon who tried to storm the heavens.",
            tags: [.giant], level: 16,
            baseAttributes: Attributes(
                strength: 24, endurance: 22, agility: 12, speed: 12, intelligence: 10, wisdom: 8,
                dexterity: 12, constitution: 24, perception: 12, luck: 10, willpower: 16),
            abilities: [.mountainPile]),
        // 58. Alpheus
        MythologicalCharacter(
            name: "Alpheus", title: "River Hunter",
            description: "A river god who pursued the nymph Arethusa.", tags: [.river], level: 14,
            baseAttributes: Attributes(
                strength: 16, endurance: 16, agility: 14, speed: 14, intelligence: 14, wisdom: 14,
                dexterity: 12, constitution: 16, perception: 16, luck: 12, willpower: 16),
            abilities: [.pursuit, .riverSurge]),
        // 59. Alpos
        MythologicalCharacter(
            name: "Alpos", title: "Sicilian Giant",
            description: "A monstrous Sicilian giant slain by Dionysus.", tags: [.giant], level: 13,
            baseAttributes: Attributes(
                strength: 22, endurance: 20, agility: 8, speed: 8, intelligence: 6, wisdom: 6,
                dexterity: 8, constitution: 22, perception: 10, luck: 6, willpower: 14),
            abilities: [.giantCrush]),
        // 60. Alseides
        MythologicalCharacter(
            name: "Alseides", title: "Grove Nymphs", description: "Dryad-nymphs of the groves.",
            tags: [.nymph, .rustic], level: 6,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 10, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 10),
            abilities: [.treeBarkSkin]),
        // 61. Amaltheia
        MythologicalCharacter(
            name: "Amaltheia", title: "Divine Goat",
            description: "The she-goat nurse of the infant Zeus.", tags: [.bestiary, .star],
            level: 14,
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 12, speed: 12, intelligence: 14, wisdom: 18,
                dexterity: 12, constitution: 14, perception: 16, luck: 20, willpower: 16),
            abilities: [.cornucopia]),
        // 62. Amechania
        MythologicalCharacter(
            name: "Amechania", title: "Helplessness",
            description: "The female personification of helplessness.", tags: [.daemon], level: 6,
            baseAttributes: Attributes(
                strength: 6, endurance: 8, agility: 6, speed: 6, intelligence: 8, wisdom: 8,
                dexterity: 6, constitution: 8, perception: 8, luck: 6, willpower: 8),
            abilities: [.despair]),
        // 63. Amnisiades
        MythologicalCharacter(
            name: "Amnisiades", title: "Artemis Attendants",
            description: "Naiad-nymph daughters of the river Amnisus.", tags: [.nymph], level: 7,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 16, speed: 16, intelligence: 12, wisdom: 12,
                dexterity: 16, constitution: 12, perception: 16, luck: 14, willpower: 12),
            abilities: [.swiftness]),
        // 64. Amnisus
        MythologicalCharacter(
            name: "Amnisus", title: "Cretan River",
            description: "A river of Crete and its watery god.", tags: [.river], level: 10,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 12, wisdom: 12,
                dexterity: 10, constitution: 16, perception: 14, luck: 12, willpower: 12),
            abilities: [.riverSurge]),
        // 65. Ampelus
        MythologicalCharacter(
            name: "Ampelus", title: "Vine Spirit",
            description: "A satyr loved by Dionysus transformed into a grape-vine.",
            tags: [.rustic], level: 8,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 12, speed: 12, intelligence: 10, wisdom: 12,
                dexterity: 12, constitution: 12, perception: 12, luck: 14, willpower: 10),
            abilities: [.intoxication]),
        // 66. Amphiaraus
        MythologicalCharacter(
            name: "Amphiaraus", title: "Underworld Oracle",
            description: "A hero swallowed by the earth who became an oracular daemon.",
            tags: [.hero, .underworld], level: 14,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 18, wisdom: 20,
                dexterity: 14, constitution: 14, perception: 22, luck: 14, willpower: 18),
            abilities: [.prophecy, .earthSwallow]),
        // 67. Amphilogiai
        MythologicalCharacter(
            name: "Amphilogiai", title: "Disputes",
            description: "The personifications of disputes.", tags: [.daemon], level: 6,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 10, speed: 10, intelligence: 10, wisdom: 10,
                dexterity: 10, constitution: 10, perception: 12, luck: 8, willpower: 10),
            abilities: [.challenge]),
        // 68. Amymone
        MythologicalCharacter(
            name: "Amymone", title: "Danaid Spring",
            description: "A Danaid nymph loved by Poseidon.", tags: [.nymph], level: 8,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 12, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 14, luck: 14, willpower: 12),
            abilities: [.riverSurge]),
        // 69. Anaideia
        MythologicalCharacter(
            name: "Anaideia", title: "Ruthlessness",
            description: "The female personification of ruthlessness.", tags: [.daemon], level: 7,
            baseAttributes: Attributes(
                strength: 12, endurance: 12, agility: 12, speed: 12, intelligence: 10, wisdom: 8,
                dexterity: 12, constitution: 12, perception: 10, luck: 10, willpower: 14),
            abilities: [.unfairBlow]),
        // 70. Ananke
        MythologicalCharacter(
            name: "Ananke", title: "Necessity",
            description: "The primordial goddess of necessity and compulsion.", tags: [.primordial],
            level: 20,
            baseAttributes: Attributes(
                strength: 25, endurance: 25, agility: 10, speed: 10, intelligence: 25, wisdom: 25,
                dexterity: 10, constitution: 25, perception: 25, luck: 10, willpower: 25),
            abilities: [.unbreakableChains]),
        // 71. Anaresineus
        MythologicalCharacter(
            name: "Anaresineus", title: "Sea Spirit",
            description: "One of the fish-tailed sea gods.", tags: [.sea], level: 12,
            baseAttributes: Attributes(
                strength: 14, endurance: 16, agility: 12, speed: 12, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 16, perception: 14, luck: 12, willpower: 14),
            abilities: [.seaStorm]),
        // 72. Anatole
        MythologicalCharacter(
            name: "Anatole", title: "Dawn Hora", description: "Goddess of the hour of dawn.",
            tags: [.personification], level: 12,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 14, speed: 14, intelligence: 14, wisdom: 16,
                dexterity: 12, constitution: 12, perception: 18, luck: 16, willpower: 14),
            abilities: [.sunrise]),
        // 73. Anax
        MythologicalCharacter(
            name: "Anax", title: "Lydian Giant", description: "A Lydian giant.", tags: [.giant],
            level: 14,
            baseAttributes: Attributes(
                strength: 20, endurance: 20, agility: 10, speed: 10, intelligence: 10, wisdom: 10,
                dexterity: 10, constitution: 20, perception: 12, luck: 12, willpower: 16),
            abilities: [.giantCrush]),
        // 74. Anchiale
        MythologicalCharacter(
            name: "Anchiale", title: "Titaness of Fire",
            description: "Titan-goddess of the warmth of fire.", tags: [.titan], level: 16,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 14, speed: 14, intelligence: 16, wisdom: 16,
                dexterity: 16, constitution: 14, perception: 16, luck: 14, willpower: 16),
            abilities: [.kilnFire]),
        // 75. Anchinoe
        MythologicalCharacter(
            name: "Anchinoe", title: "Egyptian Naiad", description: "An Egyptian Naiad.",
            tags: [.nymph, .river], level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 10),
            abilities: [.riverSurge]),
        // 76. Anchiroe (1)
        MythologicalCharacter(
            name: "Anchiroe (1)", title: "Arcadian Naiad", description: "An Arcadian Naiad-nymph.",
            tags: [.nymph], level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 10),
            abilities: [.heal]),
        // 77. Anchiroe (2)
        MythologicalCharacter(
            name: "Anchiroe (2)", title: "Libyan Naiad",
            description: "A Naiad daughter of the Libyan river Chrementes.", tags: [.nymph],
            level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 10),
            abilities: [.riverSurge]),
        // 78. Anchiroe (3)
        MythologicalCharacter(
            name: "Anchiroe (3)", title: "Erasinide",
            description: "A Naiad attendant of Britomartis.", tags: [.nymph], level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 10),
            abilities: [.springGrowth]),
        // 79. Androctasiae
        MythologicalCharacter(
            name: "Androctasiae", title: "Slaughter",
            description: "The personifications of manslaughter.", tags: [.daemon], level: 10,
            baseAttributes: Attributes(
                strength: 14, endurance: 12, agility: 14, speed: 14, intelligence: 10, wisdom: 8,
                dexterity: 14, constitution: 12, perception: 12, luck: 8, willpower: 12),
            abilities: [.bloodshed]),
        // 80. Anemoi (1)
        MythologicalCharacter(
            name: "Anemoi (1)", title: "Four Winds",
            description: "The gods of the north, south, east and west winds.",
            tags: [.wind, .titan], level: 15,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 20, speed: 20, intelligence: 16, wisdom: 16,
                dexterity: 18, constitution: 14, perception: 18, luck: 14, willpower: 16),
            abilities: [.northWindBlast, .southWindStorm, .westWindBreeze]),
        // 81. Anemoi (2)
        MythologicalCharacter(
            name: "Anemoi (2)", title: "Storm Spirits",
            description: "Daemons of the storm winds born of Typhoeus.", tags: [.wind, .daemon],
            level: 15,
            baseAttributes: Attributes(
                strength: 16, endurance: 16, agility: 20, speed: 20, intelligence: 14, wisdom: 12,
                dexterity: 18, constitution: 16, perception: 16, luck: 8, willpower: 14),
            abilities: [.bagOfWinds]),
        // 82. Angelia
        MythologicalCharacter(
            name: "Angelia", title: "Messages", description: "The goddess of messages.",
            tags: [.daemon], level: 10,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 18, speed: 18, intelligence: 14, wisdom: 12,
                dexterity: 16, constitution: 10, perception: 16, luck: 12, willpower: 10),
            abilities: [.swiftMessage]),
        // 83. Ania
        MythologicalCharacter(
            name: "Ania", title: "Trouble", description: "The female personification of trouble.",
            tags: [.daemon], level: 6,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 10, speed: 10, intelligence: 10, wisdom: 8,
                dexterity: 10, constitution: 10, perception: 10, luck: 6, willpower: 10),
            abilities: [.despair]),
        // 84. Anicetus
        MythologicalCharacter(
            name: "Anicetus", title: "Unconquerable Might",
            description: "Immortal son of Heracles and Hebe.", tags: [.deified, .hero], level: 15,
            baseAttributes: Attributes(
                strength: 20, endurance: 18, agility: 14, speed: 14, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 18, perception: 16, luck: 14, willpower: 18),
            abilities: [.wardOffWar]),
        // 85. Anigrides
        MythologicalCharacter(
            name: "Anigrides", title: "Healing Nymphs",
            description: "Naiad daughters of the river Anigrus.", tags: [.nymph, .healing],
            level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 12, wisdom: 14,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 12),
            abilities: [.curingTouch]),
        // 86. Anigrus
        MythologicalCharacter(
            name: "Anigrus", title: "Healing River", description: "A river of Elis and its god.",
            tags: [.river], level: 10,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 12, wisdom: 14,
                dexterity: 10, constitution: 16, perception: 14, luck: 12, willpower: 12),
            abilities: [.riverSurge]),
        // 87. Anippe
        MythologicalCharacter(
            name: "Anippe", title: "Nile Naiad", description: "A Naiad daughter of the River Nile.",
            tags: [.nymph, .river], level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 10),
            abilities: [.riverSurge]),
        // 88. Antaeus
        MythologicalCharacter(
            name: "Antaeus", title: "Earth-Born Giant",
            description: "A Libyan giant who drew strength from the earth.", tags: [.giant],
            level: 16,
            baseAttributes: Attributes(
                strength: 24, endurance: 24, agility: 10, speed: 10, intelligence: 10, wisdom: 10,
                dexterity: 12, constitution: 24, perception: 14, luck: 8, willpower: 18),
            abilities: [.earthRegen, .ribCrush]),
        // 89. Anteros
        MythologicalCharacter(
            name: "Anteros", title: "Avenged Love", description: "The god of unrequited love.",
            tags: [.daemon, .sky], level: 14,
            baseAttributes: Attributes(
                strength: 12, endurance: 12, agility: 16, speed: 16, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 12, perception: 16, luck: 12, willpower: 14),
            abilities: [.loveReversal]),
    ]
}
