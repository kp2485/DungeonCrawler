import Foundation

struct MythologicalCharacter {
    let name: String
    let title: String
    let baseAttributes: Attributes
    let abilities: [Ability]
}

struct GreekPantheon {
    // MARK: - Common Abilities
    static let smite = Ability(
        name: "Smite", description: "A powerful strike dealing damage based on Strength.",
        manaCost: 10, type: .damage, power: 15, attributeScaling: .strength)
    static let thunderbolt = Ability(
        name: "Thunderbolt", description: "Call down lightning on a single target.", manaCost: 20,
        type: .damage, power: 25, attributeScaling: .wisdom)
    static let heal = Ability(
        name: "Heal", description: "Restore health to a target.", manaCost: 15, type: .heal,
        power: 20, attributeScaling: .wisdom)
    static let warCry = Ability(
        name: "War Cry", description: "Boost Strength for a short time.", manaCost: 10, type: .buff,
        power: 5, attributeScaling: .strength)
    static let swiftness = Ability(
        name: "Swiftness", description: "Increase Speed and Evasion.", manaCost: 10, type: .buff,
        power: 5, attributeScaling: .agility)
    static let stealthStrike = Ability(
        name: "Stealth Strike",
        description: "A precise attack that deals high damage if undetected.", manaCost: 12,
        type: .damage, power: 20, attributeScaling: .dexterity)
    static let charm = Ability(
        name: "Charm", description: "Lower enemy attack power.", manaCost: 15, type: .debuff,
        power: 5, attributeScaling: .luck)
    static let fireball = Ability(
        name: "Fireball", description: "Launch a ball of fire.", manaCost: 15, type: .damage,
        power: 18, attributeScaling: .intelligence)
    static let ironSkin = Ability(
        name: "Iron Skin", description: "Increase defense temporarily.", manaCost: 12, type: .buff,
        power: 5, attributeScaling: .endurance)
    static let prophecy = Ability(
        name: "Prophecy", description: "Predict enemy movements, increasing hit chance.",
        manaCost: 20, type: .buff, power: 10, attributeScaling: .perception)
    static let drainLife = Ability(
        name: "Drain Life", description: "Steal health from enemy.", manaCost: 18, type: .damage,
        power: 12, attributeScaling: .willpower)
    static let quake = Ability(
        name: "Earthquake", description: "Shake the ground dealing damage to all.", manaCost: 30,
        type: .aoe, power: 15, attributeScaling: .strength)
    static let plague = Ability(
        name: "Plague", description: "Infects enemy dealing damage over time.", manaCost: 20,
        type: .debuff, power: 10, attributeScaling: .intelligence)
    static let inspire = Ability(
        name: "Inspire", description: "Boost party morale.", manaCost: 20, type: .buff, power: 5,
        attributeScaling: .willpower)

    // MARK: - Characters
    static let allCharacters: [MythologicalCharacter] = [
        // MARK: - Olympians
        MythologicalCharacter(
            name: "Zeus", title: "King of Gods",
            baseAttributes: Attributes(
                strength: 16, endurance: 14, agility: 10, speed: 12, intelligence: 14, wisdom: 18,
                dexterity: 12, constitution: 14, perception: 16, luck: 12, willpower: 18),
            abilities: [thunderbolt, smite, warCry, prophecy]),
        MythologicalCharacter(
            name: "Hera", title: "Queen of Gods",
            baseAttributes: Attributes(
                strength: 10, endurance: 14, agility: 10, speed: 10, intelligence: 16, wisdom: 16,
                dexterity: 10, constitution: 14, perception: 16, luck: 12, willpower: 18),
            abilities: [charm, smite, ironSkin, heal]),
        MythologicalCharacter(
            name: "Poseidon", title: "God of the Sea",
            baseAttributes: Attributes(
                strength: 17, endurance: 16, agility: 10, speed: 10, intelligence: 12, wisdom: 14,
                dexterity: 10, constitution: 16, perception: 12, luck: 10, willpower: 16),
            abilities: [quake, smite, warCry, ironSkin]),
        MythologicalCharacter(
            name: "Demeter", title: "Goddess of Harvest",
            baseAttributes: Attributes(
                strength: 12, endurance: 18, agility: 8, speed: 8, intelligence: 14, wisdom: 16,
                dexterity: 8, constitution: 18, perception: 12, luck: 10, willpower: 14),
            abilities: [heal, ironSkin, plague, charm]),
        MythologicalCharacter(
            name: "Ares", title: "God of War",
            baseAttributes: Attributes(
                strength: 18, endurance: 16, agility: 14, speed: 14, intelligence: 8, wisdom: 8,
                dexterity: 16, constitution: 16, perception: 12, luck: 10, willpower: 12),
            abilities: [smite, warCry, swiftness, ironSkin]),
        MythologicalCharacter(
            name: "Athena", title: "Goddess of Wisdom",
            baseAttributes: Attributes(
                strength: 14, endurance: 12, agility: 14, speed: 12, intelligence: 18, wisdom: 18,
                dexterity: 14, constitution: 12, perception: 16, luck: 10, willpower: 16),
            abilities: [prophecy, smite, stealthStrike, warCry]),
        MythologicalCharacter(
            name: "Apollo", title: "God of the Sun",
            baseAttributes: Attributes(
                strength: 14, endurance: 12, agility: 16, speed: 14, intelligence: 14, wisdom: 14,
                dexterity: 18, constitution: 12, perception: 18, luck: 12, willpower: 12),
            abilities: [fireball, heal, swiftness, prophecy]),
        MythologicalCharacter(
            name: "Artemis", title: "Goddess of the Hunt",
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 18, speed: 16, intelligence: 14, wisdom: 16,
                dexterity: 18, constitution: 12, perception: 18, luck: 10, willpower: 14),
            abilities: [stealthStrike, swiftness, prophecy, smite]),
        MythologicalCharacter(
            name: "Hephaestus", title: "God of the Forge",
            baseAttributes: Attributes(
                strength: 16, endurance: 18, agility: 8, speed: 8, intelligence: 16, wisdom: 14,
                dexterity: 14, constitution: 18, perception: 10, luck: 10, willpower: 16),
            abilities: [fireball, ironSkin, smite, quake]),
        MythologicalCharacter(
            name: "Aphrodite", title: "Goddess of Love",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 10, intelligence: 14, wisdom: 12,
                dexterity: 10, constitution: 10, perception: 14, luck: 18, willpower: 16),
            abilities: [charm, heal, inspire, prophecy]),
        MythologicalCharacter(
            name: "Hermes", title: "Messenger God",
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 18, speed: 18, intelligence: 16, wisdom: 14,
                dexterity: 16, constitution: 10, perception: 14, luck: 14, willpower: 10),
            abilities: [swiftness, stealthStrike, charm, prophecy]),
        MythologicalCharacter(
            name: "Dionysus", title: "God of Wine",
            baseAttributes: Attributes(
                strength: 10, endurance: 14, agility: 12, speed: 10, intelligence: 14, wisdom: 12,
                dexterity: 10, constitution: 16, perception: 10, luck: 18, willpower: 14),
            abilities: [charm, plague, heal, inspire]),

        // MARK: - Major Deities & Titans
        MythologicalCharacter(
            name: "Hades", title: "King of the Underworld",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 10, speed: 10, intelligence: 16, wisdom: 16,
                dexterity: 10, constitution: 14, perception: 12, luck: 8, willpower: 18),
            abilities: [drainLife, plague, thunderbolt, stealthStrike]),
        MythologicalCharacter(
            name: "Hestia", title: "Goddess of the Hearth",
            baseAttributes: Attributes(
                strength: 10, endurance: 16, agility: 8, speed: 8, intelligence: 12, wisdom: 18,
                dexterity: 8, constitution: 16, perception: 10, luck: 12, willpower: 18),
            abilities: [heal, ironSkin, fireBarrier]),
        MythologicalCharacter(
            name: "Persephone", title: "Queen of the Underworld",
            baseAttributes: Attributes(
                strength: 8, endurance: 12, agility: 10, speed: 10, intelligence: 14, wisdom: 14,
                dexterity: 8, constitution: 12, perception: 12, luck: 14, willpower: 16),
            abilities: [charm, plague, heal]),
        MythologicalCharacter(
            name: "Eros", title: "God of Desire",
            baseAttributes: Attributes(
                strength: 10, endurance: 10, agility: 16, speed: 16, intelligence: 12, wisdom: 10,
                dexterity: 16, constitution: 10, perception: 14, luck: 16, willpower: 10),
            abilities: [charm, swiftness, stealthStrike]),
        MythologicalCharacter(
            name: "Pan", title: "God of the Wild",
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 16, speed: 14, intelligence: 10, wisdom: 16,
                dexterity: 14, constitution: 14, perception: 16, luck: 14, willpower: 10),
            abilities: [swiftness, charm, quake]),
        MythologicalCharacter(
            name: "Nike", title: "Goddess of Victory",
            baseAttributes: Attributes(
                strength: 14, endurance: 12, agility: 16, speed: 16, intelligence: 12, wisdom: 12,
                dexterity: 14, constitution: 12, perception: 14, luck: 18, willpower: 14),
            abilities: [warCry, swiftness, smite]),
        MythologicalCharacter(
            name: "Hebe", title: "Goddess of Youth",
            baseAttributes: Attributes(
                strength: 8, endurance: 18, agility: 14, speed: 12, intelligence: 10, wisdom: 10,
                dexterity: 10, constitution: 18, perception: 10, luck: 14, willpower: 10),
            abilities: [heal, swiftness, charm]),
        MythologicalCharacter(
            name: "Asclepius", title: "God of Medicine",
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 10, speed: 10, intelligence: 18, wisdom: 18,
                dexterity: 14, constitution: 12, perception: 16, luck: 10, willpower: 14),
            abilities: [heal, panacea, ironSkin]),
        MythologicalCharacter(
            name: "Helios", title: "Titan of the Sun",
            baseAttributes: Attributes(
                strength: 16, endurance: 14, agility: 12, speed: 12, intelligence: 14, wisdom: 14,
                dexterity: 12, constitution: 16, perception: 18, luck: 10, willpower: 14),
            abilities: [fireball, solarFlare, prophecy, smite]),
        MythologicalCharacter(
            name: "Selene", title: "Titan of the Moon",
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 12, speed: 12, intelligence: 14, wisdom: 16,
                dexterity: 10, constitution: 12, perception: 18, luck: 12, willpower: 14),
            abilities: [moonBeam, heal, stealthStrike, prophecy]),
        MythologicalCharacter(
            name: "Eos", title: "Titan of the Dawn",
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 12, perception: 16, luck: 14, willpower: 12),
            abilities: [heal, swiftness, charm, fireball]),
        MythologicalCharacter(
            name: "Hecate", title: "Goddess of Magic",
            baseAttributes: Attributes(
                strength: 8, endurance: 12, agility: 10, speed: 10, intelligence: 18, wisdom: 18,
                dexterity: 10, constitution: 10, perception: 16, luck: 12, willpower: 18),
            abilities: [fireball, drainLife, hex, prophecy]),
        MythologicalCharacter(
            name: "Tyche", title: "Goddess of Fortune",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 12, intelligence: 10, wisdom: 10,
                dexterity: 10, constitution: 10, perception: 10, luck: 20, willpower: 10),
            abilities: [charm, luckBoost, smite]),
        MythologicalCharacter(
            name: "Nemesis", title: "Goddess of Retribution",
            baseAttributes: Attributes(
                strength: 12, endurance: 12, agility: 12, speed: 12, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 12, perception: 16, luck: 8, willpower: 16),
            abilities: [smite, hex, swiftness]),
        MythologicalCharacter(
            name: "Hypnos", title: "God of Sleep",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 8, speed: 8, intelligence: 14, wisdom: 14,
                dexterity: 8, constitution: 10, perception: 12, luck: 10, willpower: 18),
            abilities: [sleep, healingDream, charm]),
        MythologicalCharacter(
            name: "Thanatos", title: "God of Death",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 16, wisdom: 16,
                dexterity: 12, constitution: 14, perception: 14, luck: 6, willpower: 18),
            abilities: [deathScythe, drainLife, stealthStrike]),
        MythologicalCharacter(
            name: "Prometheus", title: "Titan of Fire",
            baseAttributes: Attributes(
                strength: 14, endurance: 18, agility: 10, speed: 10, intelligence: 18, wisdom: 16,
                dexterity: 10, constitution: 18, perception: 14, luck: 10, willpower: 18),
            abilities: [fireball, foresight, heal, ironSkin]),

        // MARK: - Underworld Figures
        MythologicalCharacter(
            name: "Charon", title: "Ferryman of Hades",
            baseAttributes: Attributes(
                strength: 14, endurance: 16, agility: 8, speed: 8, intelligence: 14, wisdom: 16,
                dexterity: 8, constitution: 16, perception: 14, luck: 10, willpower: 18),
            abilities: [drainLife, coinToss, ironSkin]),
        MythologicalCharacter(
            name: "Cerberus", title: "Hound of Hades",
            baseAttributes: Attributes(
                strength: 18, endurance: 18, agility: 14, speed: 14, intelligence: 6, wisdom: 8,
                dexterity: 12, constitution: 18, perception: 18, luck: 8, willpower: 12),
            abilities: [bite, howl, quake]),
        MythologicalCharacter(
            name: "Nyx", title: "Primordial Night",
            baseAttributes: Attributes(
                strength: 12, endurance: 12, agility: 12, speed: 12, intelligence: 18, wisdom: 18,
                dexterity: 12, constitution: 12, perception: 18, luck: 12, willpower: 20),
            abilities: [darkness, drainLife, hypnosCall, stealthStrike]),
        MythologicalCharacter(
            name: "Erebus", title: "Primordial Darkness",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 16, wisdom: 16,
                dexterity: 12, constitution: 14, perception: 16, luck: 10, willpower: 18),
            abilities: [shadowStrike, darkness, drainLife, fear]),
        MythologicalCharacter(
            name: "Tartarus", title: "The Pit",
            baseAttributes: Attributes(
                strength: 20, endurance: 20, agility: 6, speed: 6, intelligence: 14, wisdom: 14,
                dexterity: 6, constitution: 20, perception: 10, luck: 6, willpower: 20),
            abilities: [abyssConsume, quake, fear, ironSkin]),
        MythologicalCharacter(
            name: "Styx", title: "River of Hate",
            baseAttributes: Attributes(
                strength: 12, endurance: 18, agility: 12, speed: 12, intelligence: 14, wisdom: 16,
                dexterity: 12, constitution: 18, perception: 14, luck: 10, willpower: 18),
            abilities: [poisonWater, invincibleSkin, oathBreaker]),
        MythologicalCharacter(
            name: "Minos", title: "Judge of the Dead",
            baseAttributes: Attributes(
                strength: 16, endurance: 14, agility: 10, speed: 10, intelligence: 16, wisdom: 18,
                dexterity: 10, constitution: 14, perception: 16, luck: 12, willpower: 18),
            abilities: [judgement, smite, command]),
        MythologicalCharacter(
            name: "Rhadamanthus", title: "Judge of the Dead",
            baseAttributes: Attributes(
                strength: 14, endurance: 16, agility: 10, speed: 10, intelligence: 16, wisdom: 18,
                dexterity: 10, constitution: 16, perception: 16, luck: 12, willpower: 18),
            abilities: [judgement, ironLaw, smite]),
        MythologicalCharacter(
            name: "Aeacus", title: "Judge of the Dead",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 10, speed: 10, intelligence: 16, wisdom: 18,
                dexterity: 10, constitution: 14, perception: 16, luck: 12, willpower: 18),
            abilities: [judgement, keyKeeper, smite]),
        MythologicalCharacter(
            name: "Alecto", title: "Fury of Anger",
            baseAttributes: Attributes(
                strength: 16, endurance: 14, agility: 16, speed: 16, intelligence: 10, wisdom: 10,
                dexterity: 16, constitution: 14, perception: 14, luck: 8, willpower: 16),
            abilities: [furySwipe, rage, chase]),
        MythologicalCharacter(
            name: "Megaera", title: "Fury of Jealousy",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 16, speed: 16, intelligence: 12, wisdom: 10,
                dexterity: 16, constitution: 14, perception: 14, luck: 8, willpower: 16),
            abilities: [furySwipe, envyCurse, chase]),
        MythologicalCharacter(
            name: "Tisiphone", title: "Fury of Vengeance",
            baseAttributes: Attributes(
                strength: 15, endurance: 15, agility: 16, speed: 16, intelligence: 10, wisdom: 10,
                dexterity: 16, constitution: 15, perception: 14, luck: 8, willpower: 16),
            abilities: [furySwipe, avenge, killerInstinct]),
        MythologicalCharacter(
            name: "Melinoe", title: "Bringer of Nightmares",
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 14, speed: 14, intelligence: 16, wisdom: 14,
                dexterity: 14, constitution: 12, perception: 16, luck: 10, willpower: 16),
            abilities: [ghostCall, fear, stealthStrike]),
        MythologicalCharacter(
            name: "Zagreus", title: "Prince of Underworld",
            baseAttributes: Attributes(
                strength: 16, endurance: 16, agility: 16, speed: 16, intelligence: 12, wisdom: 12,
                dexterity: 16, constitution: 16, perception: 14, luck: 14, willpower: 16),
            abilities: [bloodBurst, swiftDash, deathDefiance]),
        MythologicalCharacter(
            name: "Eurydice", title: "Oak Nymph",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 10, perception: 16, luck: 10, willpower: 14),
            abilities: [natureHeal, stealthStrike, songOfSorrow]),

        // MARK: - Heroes
        MythologicalCharacter(
            name: "Hercules", title: "Son of Zeus",
            baseAttributes: Attributes(
                strength: 20, endurance: 18, agility: 10, speed: 10, intelligence: 10, wisdom: 10,
                dexterity: 12, constitution: 18, perception: 10, luck: 10, willpower: 16),
            abilities: [mightyBlow, quake, warCry]),
        MythologicalCharacter(
            name: "Achilles", title: "Hero of Troy",
            baseAttributes: Attributes(
                strength: 18, endurance: 16, agility: 16, speed: 14, intelligence: 12, wisdom: 10,
                dexterity: 16, constitution: 16, perception: 14, luck: 8, willpower: 14),
            abilities: [swiftStrike, rage, warCry]),
        MythologicalCharacter(
            name: "Odysseus", title: "King of Ithaca",
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 12, speed: 12, intelligence: 18, wisdom: 16,
                dexterity: 14, constitution: 14, perception: 16, luck: 14, willpower: 18),
            abilities: [tacticalPlan, stealthStrike, charm]),
        MythologicalCharacter(
            name: "Perseus", title: "Slayer of Gorgons",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 14, constitution: 12, perception: 12, luck: 16, willpower: 14),
            abilities: [shieldBash, stealthStrike, wingedFlight]),
        MythologicalCharacter(
            name: "Theseus", title: "Slayer of Minotaurs",
            baseAttributes: Attributes(
                strength: 16, endurance: 14, agility: 14, speed: 12, intelligence: 14, wisdom: 12,
                dexterity: 12, constitution: 14, perception: 12, luck: 12, willpower: 14),
            abilities: [monstrousStrike, warCry, swiftness]),
        MythologicalCharacter(
            name: "Jason", title: "Leader of Argonauts",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 14, perception: 12, luck: 14, willpower: 14),
            abilities: [inspire, teamStrike, shieldWall]),
        MythologicalCharacter(
            name: "Atalanta", title: "Swift Huntress",
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 18, speed: 18, intelligence: 12, wisdom: 12,
                dexterity: 16, constitution: 12, perception: 16, luck: 12, willpower: 12),
            abilities: [swiftness, volley, huntersMark]),
        MythologicalCharacter(
            name: "Orpheus", title: "Legendary Musician",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 12, intelligence: 14, wisdom: 12,
                dexterity: 14, constitution: 10, perception: 14, luck: 12, willpower: 18),
            abilities: [charm, soothe, sonnet]),
        MythologicalCharacter(
            name: "Bellerophon", title: "Slayer of Chimera",
            baseAttributes: Attributes(
                strength: 14, endurance: 12, agility: 14, speed: 14, intelligence: 10, wisdom: 10,
                dexterity: 14, constitution: 12, perception: 12, luck: 14, willpower: 12),
            abilities: [aerialStrike, pierce, mountPegasus]),
        MythologicalCharacter(
            name: "Cadmus", title: "Founder of Thebes",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 14, wisdom: 14,
                dexterity: 12, constitution: 14, perception: 12, luck: 12, willpower: 14),
            abilities: [sowTeeth, inspire, strike]),
        MythologicalCharacter(
            name: "Hector", title: "Prince of Troy",
            baseAttributes: Attributes(
                strength: 16, endurance: 16, agility: 12, speed: 12, intelligence: 14, wisdom: 12,
                dexterity: 14, constitution: 16, perception: 12, luck: 8, willpower: 16),
            abilities: [defendTroy, warCry, heavyBlow]),
        MythologicalCharacter(
            name: "Paris", title: "Prince of Troy",
            baseAttributes: Attributes(
                strength: 10, endurance: 10, agility: 12, speed: 12, intelligence: 10, wisdom: 8,
                dexterity: 18, constitution: 10, perception: 12, luck: 14, willpower: 8),
            abilities: [aimedShot, escape, charm]),
        MythologicalCharacter(
            name: "Aeneas", title: "Trojan Hero",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 12, wisdom: 14,
                dexterity: 12, constitution: 14, perception: 12, luck: 14, willpower: 16),
            abilities: [divineProtection, rally, strike]),
        MythologicalCharacter(
            name: "Castor", title: "Twin of Pollux",
            baseAttributes: Attributes(
                strength: 14, endurance: 12, agility: 14, speed: 14, intelligence: 10, wisdom: 10,
                dexterity: 14, constitution: 12, perception: 12, luck: 12, willpower: 12),
            abilities: [twinStrike, swiftness, ride]),
        MythologicalCharacter(
            name: "Pollux", title: "Twin of Castor",
            baseAttributes: Attributes(
                strength: 16, endurance: 14, agility: 12, speed: 12, intelligence: 10, wisdom: 10,
                dexterity: 12, constitution: 14, perception: 12, luck: 12, willpower: 12),
            abilities: [boxerBlow, twinStrike, endure]),
        MythologicalCharacter(
            name: "Hippolyta", title: "Amazon Queen",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 16, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 16, constitution: 14, perception: 14, luck: 10, willpower: 14),
            abilities: [amazonStrike, rally, warCry]),
        MythologicalCharacter(
            name: "Penthesilea", title: "Amazon Warrior",
            baseAttributes: Attributes(
                strength: 16, endurance: 14, agility: 16, speed: 16, intelligence: 10, wisdom: 10,
                dexterity: 16, constitution: 14, perception: 12, luck: 10, willpower: 14),
            abilities: [furiousCharge, rage, slash]),
        MythologicalCharacter(
            name: "Ajax (Great)", title: "Tower of Power",
            baseAttributes: Attributes(
                strength: 18, endurance: 18, agility: 8, speed: 8, intelligence: 10, wisdom: 8,
                dexterity: 10, constitution: 18, perception: 10, luck: 10, willpower: 14),
            abilities: [shieldBash, immovable, heavyBlow]),
        MythologicalCharacter(
            name: "Diomedes", title: "Favorite of Athena",
            baseAttributes: Attributes(
                strength: 16, endurance: 16, agility: 14, speed: 14, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 16, perception: 14, luck: 12, willpower: 14),
            abilities: [godWound, tacticalStrike, rally]),
        MythologicalCharacter(
            name: "Patroclus", title: "Companion of Achilles",
            baseAttributes: Attributes(
                strength: 12, endurance: 12, agility: 12, speed: 12, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 12, perception: 12, luck: 10, willpower: 12),
            abilities: [impersonate, heal, support]),

        // MARK: - Major Figures
        MythologicalCharacter(
            name: "Chiron", title: "Trainer of Heroes",
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 18, wisdom: 20,
                dexterity: 12, constitution: 14, perception: 16, luck: 12, willpower: 16),
            abilities: [heal, teach, aim]),
        MythologicalCharacter(
            name: "Medea", title: "Colchian Sorceress",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 10, speed: 10, intelligence: 18, wisdom: 16,
                dexterity: 10, constitution: 10, perception: 14, luck: 10, willpower: 16),
            abilities: [fireball, poison, hex]),
        MythologicalCharacter(
            name: "Circe", title: "Enchantress of Aeaea",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 10, speed: 10, intelligence: 18, wisdom: 18,
                dexterity: 10, constitution: 10, perception: 14, luck: 12, willpower: 16),
            abilities: [polymorph, charm, potion]),
        MythologicalCharacter(
            name: "Pandora", title: "Bearer of the Box",
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 12, intelligence: 14, wisdom: 8,
                dexterity: 12, constitution: 10, perception: 14, luck: 6, willpower: 8),
            abilities: [openBox, hope, plague]),
    ]

    // Placeholder definitions for specific unique abilities used above
    static let fireBarrier = Ability(
        name: "Fire Barrier", description: "Shield of flames.", manaCost: 15, type: .buff,
        power: 10, attributeScaling: .intelligence)
    static let panacea = Ability(
        name: "Panacea", description: "Cure all ailments.", manaCost: 20, type: .heal, power: 30,
        attributeScaling: .wisdom)
    static let solarFlare = Ability(
        name: "Solar Flare", description: "Blinding light damage.", manaCost: 20, type: .aoe,
        power: 20, attributeScaling: .intelligence)
    static let moonBeam = Ability(
        name: "Moonbeam", description: "Lunar damage.", manaCost: 15, type: .damage, power: 18,
        attributeScaling: .wisdom)
    static let hex = Ability(
        name: "Hex", description: "Curse enemy.", manaCost: 10, type: .debuff, power: 5,
        attributeScaling: .intelligence)
    static let luckBoost = Ability(
        name: "Luck Boost", description: "Increase Luck.", manaCost: 10, type: .buff, power: 10,
        attributeScaling: .luck)
    static let sleep = Ability(
        name: "Sleep", description: "Put enemy to sleep.", manaCost: 15, type: .debuff, power: 0,
        attributeScaling: .willpower)
    static let healingDream = Ability(
        name: "Healing Dream", description: "Heal while sleeping.", manaCost: 10, type: .heal,
        power: 15, attributeScaling: .wisdom)
    static let deathScythe = Ability(
        name: "Death Scythe", description: "Reap soul.", manaCost: 25, type: .damage, power: 30,
        attributeScaling: .strength)
    static let foresight = Ability(
        name: "Foresight", description: "Predict attacks.", manaCost: 10, type: .buff, power: 10,
        attributeScaling: .wisdom)
    static let coinToss = Ability(
        name: "Coin Toss", description: "Distract or deal damage.", manaCost: 5, type: .utility,
        power: 5, attributeScaling: .luck)
    static let bite = Ability(
        name: "Bite", description: "Vicious bite.", manaCost: 5, type: .damage, power: 15,
        attributeScaling: .strength)
    static let howl = Ability(
        name: "Howl", description: "Terrify enemies.", manaCost: 10, type: .debuff, power: 5,
        attributeScaling: .strength)
    static let darkness = Ability(
        name: "Darkness", description: "Blind enemies.", manaCost: 15, type: .debuff, power: 10,
        attributeScaling: .willpower)
    static let hypnosCall = Ability(
        name: "Call Hypnos", description: "Sleep aid.", manaCost: 10, type: .debuff, power: 0,
        attributeScaling: .willpower)
    static let shadowStrike = Ability(
        name: "Shadow Strike", description: "Attack from shadows.", manaCost: 15, type: .damage,
        power: 20, attributeScaling: .dexterity)
    static let fear = Ability(
        name: "Fear", description: "Scare enemy.", manaCost: 10, type: .debuff, power: 5,
        attributeScaling: .willpower)
    static let abyssConsume = Ability(
        name: "Abyss Consume", description: "Devour target.", manaCost: 30, type: .damage,
        power: 40, attributeScaling: .strength)
    static let poisonWater = Ability(
        name: "Poison Water", description: "Toxic damage.", manaCost: 15, type: .damage, power: 15,
        attributeScaling: .constitution)
    static let invincibleSkin = Ability(
        name: "Invincible Skin", description: "High defense.", manaCost: 20, type: .buff, power: 20,
        attributeScaling: .endurance)
    static let oathBreaker = Ability(
        name: "Oath Breaker", description: "Punish.", manaCost: 20, type: .damage, power: 25,
        attributeScaling: .willpower)
    static let judgement = Ability(
        name: "Judgement", description: "Holy damage.", manaCost: 20, type: .damage, power: 25,
        attributeScaling: .wisdom)
    static let command = Ability(
        name: "Command", description: "Order allies.", manaCost: 10, type: .buff, power: 5,
        attributeScaling: .willpower)
    static let ironLaw = Ability(
        name: "Iron Law", description: "Restrict enemy.", manaCost: 15, type: .debuff, power: 5,
        attributeScaling: .willpower)
    static let keyKeeper = Ability(
        name: "Key Keeper", description: "Lock/Unlock.", manaCost: 10, type: .utility, power: 0,
        attributeScaling: .wisdom)
    static let furySwipe = Ability(
        name: "Fury Swipe", description: "Claw attack.", manaCost: 10, type: .damage, power: 15,
        attributeScaling: .dexterity)
    static let rage = Ability(
        name: "Rage", description: "Increase damage taken and dealt.", manaCost: 10, type: .buff,
        power: 10, attributeScaling: .strength)
    static let chase = Ability(
        name: "Chase", description: "Pursue fleeing enemy.", manaCost: 5, type: .utility, power: 0,
        attributeScaling: .speed)
    static let envyCurse = Ability(
        name: "Envy", description: "Steal stats.", manaCost: 15, type: .debuff, power: 5,
        attributeScaling: .willpower)
    static let avenge = Ability(
        name: "Avenge", description: "Reflect damage.", manaCost: 15, type: .buff, power: 10,
        attributeScaling: .willpower)
    static let killerInstinct = Ability(
        name: "Killer Instinct", description: "Crit boost.", manaCost: 10, type: .buff, power: 10,
        attributeScaling: .perception)
    static let ghostCall = Ability(
        name: "Ghost Call", description: "Summon spirits.", manaCost: 20, type: .aoe, power: 10,
        attributeScaling: .willpower)
    static let bloodBurst = Ability(
        name: "Blood Burst", description: "Explosive damage.", manaCost: 15, type: .aoe, power: 20,
        attributeScaling: .strength)
    static let swiftDash = Ability(
        name: "Swift Dash", description: "Move quickly.", manaCost: 5, type: .buff, power: 10,
        attributeScaling: .speed)
    static let deathDefiance = Ability(
        name: "Death Defiance", description: "Revive once.", manaCost: 50, type: .buff, power: 100,
        attributeScaling: .luck)
    static let natureHeal = Ability(
        name: "Nature Heal", description: "Regen.", manaCost: 15, type: .heal, power: 15,
        attributeScaling: .wisdom)
    static let songOfSorrow = Ability(
        name: "Song of Sorrow", description: "Reduce enemy morale.", manaCost: 10, type: .debuff,
        power: 5, attributeScaling: .willpower)
    static let mightyBlow = Ability(
        name: "Mighty Blow", description: "Huge damage.", manaCost: 20, type: .damage, power: 30,
        attributeScaling: .strength)
    static let swiftStrike = Ability(
        name: "Swift Strike", description: "Fast attack.", manaCost: 10, type: .damage, power: 15,
        attributeScaling: .speed)
    static let tacticalPlan = Ability(
        name: "Tactical Plan", description: "Boost ally hit chance.", manaCost: 15, type: .buff,
        power: 10, attributeScaling: .intelligence)
    static let shieldBash = Ability(
        name: "Shield Bash", description: "Stun enemy.", manaCost: 15, type: .damage, power: 10,
        attributeScaling: .strength)
    static let wingedFlight = Ability(
        name: "Winged Flight", description: "Fly.", manaCost: 20, type: .buff, power: 20,
        attributeScaling: .speed)
    static let monstrousStrike = Ability(
        name: "Monstrous Strike", description: "Heavy hit.", manaCost: 15, type: .damage, power: 20,
        attributeScaling: .strength)
    static let teamStrike = Ability(
        name: "Team Strike", description: "Attack with ally.", manaCost: 20, type: .damage,
        power: 25, attributeScaling: .willpower)
    static let shieldWall = Ability(
        name: "Shield Wall", description: "Defense up.", manaCost: 15, type: .buff, power: 10,
        attributeScaling: .endurance)
    static let volley = Ability(
        name: "Volley", description: "Arrow rain.", manaCost: 20, type: .aoe, power: 15,
        attributeScaling: .dexterity)
    static let huntersMark = Ability(
        name: "Hunter's Mark", description: "Mark target.", manaCost: 10, type: .debuff, power: 10,
        attributeScaling: .perception)
    static let soothe = Ability(
        name: "Soothe", description: "Calm enemy.", manaCost: 10, type: .debuff, power: 10,
        attributeScaling: .willpower)
    static let sonnet = Ability(
        name: "Sonnet", description: "Buff ally.", manaCost: 10, type: .buff, power: 5,
        attributeScaling: .willpower)
    static let aerialStrike = Ability(
        name: "Aerial Strike", description: "Death from above.", manaCost: 15, type: .damage,
        power: 20, attributeScaling: .agility)
    static let pierce = Ability(
        name: "Pierce", description: "Ignore armor.", manaCost: 12, type: .damage, power: 18,
        attributeScaling: .strength)
    static let mountPegasus = Ability(
        name: "Pegasus", description: "Speed boost.", manaCost: 20, type: .buff, power: 20,
        attributeScaling: .speed)
    static let sowTeeth = Ability(
        name: "Sow Teeth", description: "Summon warrior.", manaCost: 25, type: .utility, power: 0,
        attributeScaling: .intelligence)  // Magic -> Intelligence
    static let strike = Ability(
        name: "Strike", description: "Basic hit.", manaCost: 5, type: .damage, power: 10,
        attributeScaling: .strength)
    static let defendTroy = Ability(
        name: "Defend", description: "Defense boost.", manaCost: 10, type: .buff, power: 10,
        attributeScaling: .endurance)
    static let heavyBlow = Ability(
        name: "Heavy Blow", description: "Big hit.", manaCost: 15, type: .damage, power: 20,
        attributeScaling: .strength)
    static let aimedShot = Ability(
        name: "Aimed Shot", description: "Precise hit.", manaCost: 10, type: .damage, power: 15,
        attributeScaling: .dexterity)
    static let escape = Ability(
        name: "Escape", description: "Flee.", manaCost: 10, type: .utility, power: 0,
        attributeScaling: .speed)
    static let divineProtection = Ability(
        name: "Divine Protection", description: "Shield.", manaCost: 20, type: .buff, power: 15,
        attributeScaling: .willpower)
    static let rally = Ability(
        name: "Rally", description: "Heal/Buff.", manaCost: 15, type: .buff, power: 10,
        attributeScaling: .willpower)
    static let twinStrike = Ability(
        name: "Twin Strike", description: "Double hit.", manaCost: 15, type: .damage, power: 20,
        attributeScaling: .dexterity)
    static let ride = Ability(
        name: "Ride", description: "Speed up.", manaCost: 10, type: .buff, power: 10,
        attributeScaling: .speed)
    static let boxerBlow = Ability(
        name: "Boxer Strike", description: "Punch.", manaCost: 10, type: .damage, power: 15,
        attributeScaling: .strength)
    static let endure = Ability(
        name: "Endure", description: "Heal self.", manaCost: 15, type: .heal, power: 15,
        attributeScaling: .endurance)
    static let amazonStrike = Ability(
        name: "Amazon Strike", description: "Hit.", manaCost: 10, type: .damage, power: 15,
        attributeScaling: .strength)
    static let furiousCharge = Ability(
        name: "Furious Charge", description: "Charge.", manaCost: 15, type: .damage, power: 20,
        attributeScaling: .speed)
    static let slash = Ability(
        name: "Slash", description: "Cut.", manaCost: 10, type: .damage, power: 12,
        attributeScaling: .dexterity)
    static let immovable = Ability(
        name: "Immovable", description: "Defense up.", manaCost: 15, type: .buff, power: 20,
        attributeScaling: .strength)
    static let godWound = Ability(
        name: "God Wound", description: "Hurt god.", manaCost: 30, type: .damage, power: 30,
        attributeScaling: .strength)
    static let tacticalStrike = Ability(
        name: "Tactical Strike", description: "Smart hit.", manaCost: 12, type: .damage, power: 15,
        attributeScaling: .intelligence)
    static let impersonate = Ability(
        name: "Impersonate", description: "Decoy.", manaCost: 15, type: .utility, power: 0,
        attributeScaling: .willpower)
    static let support = Ability(
        name: "Support", description: "Aid ally.", manaCost: 10, type: .heal, power: 10,
        attributeScaling: .wisdom)
    static let teach = Ability(
        name: "Teach", description: "XP boost.", manaCost: 10, type: .utility, power: 0,
        attributeScaling: .wisdom)
    static let aim = Ability(
        name: "Aim", description: "Hit chance up.", manaCost: 5, type: .buff, power: 10,
        attributeScaling: .perception)
    static let poison = Ability(
        name: "Poison", description: "DoT.", manaCost: 15, type: .debuff, power: 10,
        attributeScaling: .intelligence)
    static let polymorph = Ability(
        name: "Polymorph", description: "Pig.", manaCost: 25, type: .debuff, power: 0,
        attributeScaling: .intelligence)
    static let potion = Ability(
        name: "Potion", description: "Heal.", manaCost: 10, type: .heal, power: 20,
        attributeScaling: .intelligence)
    static let openBox = Ability(
        name: "Open Box", description: "Chaos.", manaCost: 50, type: .aoe, power: 50,
        attributeScaling: .luck)
    static let hope = Ability(
        name: "Hope", description: "Small heal.", manaCost: 5, type: .heal, power: 5,
        attributeScaling: .willpower)
}
