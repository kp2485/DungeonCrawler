import Foundation

extension EncyclopediaA {
    static let part1: [MythologicalCharacter] = [
        // 1. Achelous
        MythologicalCharacter(
            name: "Achelous", title: "River God of Aetolia",
            description:
                "A river of Aetolia in Greece and its god who wrestled Heracles for the hand of Deianeira.",
            tags: [.river, .rustic], level: 18,
            baseAttributes: Attributes(
                strength: 22, endurance: 24, agility: 14, speed: 14, intelligence: 16, wisdom: 18,
                dexterity: 12, constitution: 24, perception: 16, luck: 12, willpower: 18),
            abilities: [.hornStrike, .riverWrestling]),
        // 2. Aba
        MythologicalCharacter(
            name: "Aba", title: "Thracian Nymph",
            description: "A Thracian nymph loved by Poseidon.", tags: [.nymph], level: 6,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 10, wisdom: 10,
                dexterity: 12, constitution: 10, perception: 12, luck: 14, willpower: 10),
            abilities: [.thracianCharm]),
        // 3. Abarbaree
        MythologicalCharacter(
            name: "Abarbaree", title: "Bucolic Naiad",
            description: "A Mysian nymph loved by the Trojan prince Bucolion.",
            tags: [.nymph, .rustic], level: 6,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 10, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 10),
            abilities: [.bucolicGrace]),
        // 4. Aceso
        MythologicalCharacter(
            name: "Aceso", title: "Goddess of Curing",
            description: "The goddess of curing illness and healing wounds.",
            tags: [.healing, .deified], level: 14,
            baseAttributes: Attributes(
                strength: 10, endurance: 14, agility: 12, speed: 12, intelligence: 18, wisdom: 20,
                dexterity: 16, constitution: 14, perception: 18, luck: 14, willpower: 16),
            abilities: [.curingTouch, .heal]),
        // 5. Acheloides
        MythologicalCharacter(
            name: "Acheloides", title: "Naiad Daughters",
            description:
                "The Naiad daughters of the river Achelous who attended the god in his river-bed palace.",
            tags: [.nymph, .river], level: 8,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 16, speed: 16, intelligence: 12, wisdom: 12,
                dexterity: 14, constitution: 12, perception: 14, luck: 12, willpower: 12),
            abilities: [.sirenSong, .riverSurge]),
        // 6. Acheron
        MythologicalCharacter(
            name: "Acheron", title: "River of Pain",
            description: "The underworld river of pain and its god.", tags: [.underworld, .river],
            level: 18,
            baseAttributes: Attributes(
                strength: 20, endurance: 22, agility: 12, speed: 12, intelligence: 18, wisdom: 18,
                dexterity: 12, constitution: 22, perception: 16, luck: 8, willpower: 20),
            abilities: [.riverOfPain]),
        // 7. Achlys
        MythologicalCharacter(
            name: "Achlys", title: "Death Mist",
            description:
                "The ugly hag who personified the death-mist, the clouding of the eyes of the dead.",
            tags: [.daemon, .underworld], level: 20,
            baseAttributes: Attributes(
                strength: 14, endurance: 18, agility: 14, speed: 14, intelligence: 18, wisdom: 20,
                dexterity: 14, constitution: 18, perception: 20, luck: 6, willpower: 22),
            abilities: [.deathMist]),
        // 8. Acis
        MythologicalCharacter(
            name: "Acis", title: "Sicilian River Spirit",
            description:
                "A boy loved by the Nereid Galatea who was crushed beneath a rock by the jealous Cyclops Polyphemus.",
            tags: [.river, .rustic], level: 10,
            baseAttributes: Attributes(
                strength: 12, endurance: 12, agility: 16, speed: 16, intelligence: 12, wisdom: 12,
                dexterity: 14, constitution: 12, perception: 14, luck: 10, willpower: 12),
            abilities: [.sicilianSpring]),
        // 9. Acmon (1)
        MythologicalCharacter(
            name: "Acmon (1)", title: "Dactyl Smith",
            description: "One of the metal-working Dactyls.", tags: [.daemon, .rustic], level: 12,
            baseAttributes: Attributes(
                strength: 18, endurance: 18, agility: 12, speed: 12, intelligence: 14, wisdom: 12,
                dexterity: 16, constitution: 18, perception: 14, luck: 12, willpower: 14),
            abilities: [.anvilStrike]),
        // 10. Acmon (2)
        MythologicalCharacter(
            name: "Acmon (2)", title: "Cercope Trickster",
            description: "One of the monkey-like Cercopes.", tags: [.daemon, .bestiary], level: 8,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 18, speed: 18, intelligence: 12, wisdom: 10,
                dexterity: 18, constitution: 12, perception: 16, luck: 16, willpower: 10),
            abilities: [.monkeyTrick]),
        // 11. Acraea
        MythologicalCharacter(
            name: "Acraea", title: "Nurse of Hera",
            description:
                "A Naiad daughter of the river Asterion who nursed the infant goddess Hera.",
            tags: [.nymph], level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 12, intelligence: 12, wisdom: 14,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 12),
            abilities: [.nursesCare]),
        // 12. Acratus
        MythologicalCharacter(
            name: "Acratus", title: "Daemon of Unmixed Wine",
            description: "The daemon of unmixed wine and incontinence.", tags: [.daemon, .rustic],
            level: 5,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 10, speed: 10, intelligence: 8, wisdom: 8,
                dexterity: 10, constitution: 14, perception: 10, luck: 14, willpower: 8),
            abilities: [.intoxication]),
        // 13. Acte
        MythologicalCharacter(
            name: "Acte", title: "Hora of Afternoon",
            description: "The ninth of the twelve Horai and goddess of an hour of the afternoon.",
            tags: [.personification], level: 12,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 14, speed: 14, intelligence: 14, wisdom: 14,
                dexterity: 12, constitution: 12, perception: 16, luck: 14, willpower: 12),
            abilities: [.afternoonSun]),
        // 14. Adephagia
        MythologicalCharacter(
            name: "Adephagia", title: "Goddess of Gluttony",
            description: "The goddess of gluttony.", tags: [.daemon, .personification], level: 8,
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 8, speed: 8, intelligence: 10, wisdom: 8,
                dexterity: 10, constitution: 16, perception: 10, luck: 10, willpower: 12),
            abilities: [.ravenousHunger]),
        // 15. Adicia
        MythologicalCharacter(
            name: "Adicia", title: "Injustice",
            description: "The female personification of injustice.",
            tags: [.daemon, .personification], level: 8,
            baseAttributes: Attributes(
                strength: 14, endurance: 12, agility: 12, speed: 12, intelligence: 12, wisdom: 8,
                dexterity: 12, constitution: 12, perception: 10, luck: 8, willpower: 10),
            abilities: [.unfairBlow]),
        // 16. Adrasteia
        MythologicalCharacter(
            name: "Adrasteia", title: "Inevitability",
            description: "One of the nurses of Zeus in Crete, sometimes associated with Nemesis.",
            tags: [.nymph, .personification], level: 15,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 16, speed: 16, intelligence: 18, wisdom: 18,
                dexterity: 16, constitution: 14, perception: 20, luck: 14, willpower: 18),
            abilities: [.inevitableRetribution]),
        // 17. Amphitrite
        MythologicalCharacter(
            name: "Amphitrite", title: "Queen of the Sea",
            description: "The goddess-queen of the sea, wife of Poseidon.",
            tags: [.sea, .olympian], level: 18,
            baseAttributes: Attributes(
                strength: 16, endurance: 18, agility: 16, speed: 18, intelligence: 18, wisdom: 20,
                dexterity: 16, constitution: 18, perception: 20, luck: 16, willpower: 18),
            abilities: [.tidalWave, .summonSeaMonsters]),
        // 18. Aea
        MythologicalCharacter(
            name: "Aea", title: "Colchian Nymph",
            description: "A Nymph loved by the Colchian river-god Phasis.", tags: [.nymph],
            level: 6,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 12, intelligence: 12, wisdom: 10,
                dexterity: 12, constitution: 10, perception: 12, luck: 12, willpower: 10),
            abilities: [.colchisMagic]),
        // 19. Aeacus
        MythologicalCharacter(
            name: "Aeacus", title: "Judge of the Dead",
            description:
                "One of the three Judges of the Underworld who was a king of Aegina appointed to the position after death.",
            tags: [.underworld, .deified], level: 16,
            baseAttributes: Attributes(
                strength: 14, endurance: 16, agility: 12, speed: 12, intelligence: 18, wisdom: 22,
                dexterity: 12, constitution: 16, perception: 20, luck: 14, willpower: 20),
            abilities: [.underworldJudgment, .antMyrmidons]),
        // 20. Aedos
        MythologicalCharacter(
            name: "Aedos", title: "Modesty", description: "The goddess of modesty and respect.",
            tags: [.daemon, .personification], level: 10,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 12, intelligence: 14, wisdom: 14,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 16),
            abilities: [.humbleAura]),
        // 21. Aegaeon (1)
        MythologicalCharacter(
            name: "Aegaeon (1)", title: "Sea God",
            description: "An ancient sea-god allied with the Titans.", tags: [.sea, .titan],
            level: 16,
            baseAttributes: Attributes(
                strength: 22, endurance: 20, agility: 14, speed: 14, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 20, perception: 16, luck: 12, willpower: 16),
            abilities: [.seaStorm, .hundredHandSlap]),
        // 22. Aegaeon (2)
        MythologicalCharacter(
            name: "Aegaeon (2)", title: "Gigante",
            description: "One of the Gigantes who made war on the gods.", tags: [.giant], level: 15,
            baseAttributes: Attributes(
                strength: 24, endurance: 22, agility: 10, speed: 10, intelligence: 8, wisdom: 8,
                dexterity: 12, constitution: 24, perception: 12, luck: 8, willpower: 16),
            abilities: [.giantCrush]),
        // 23. Aegaeus
        MythologicalCharacter(
            name: "Aegaeus", title: "River God",
            description: "A river of Scheria, island of the Phaeacians, and its god.",
            tags: [.river], level: 10,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 12, wisdom: 12,
                dexterity: 10, constitution: 14, perception: 12, luck: 10, willpower: 12),
            abilities: [.riverSurge]),
        // 24. Aegeirus
        MythologicalCharacter(
            name: "Aegeirus", title: "Poplar Nymph",
            description: "The Hamadryad nymph of the poplar tree.", tags: [.nymph, .rustic],
            level: 6,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 10, speed: 10, intelligence: 10, wisdom: 12,
                dexterity: 10, constitution: 10, perception: 12, luck: 10, willpower: 10),
            abilities: [.poplarRustle]),
        // 25. Aegina
        MythologicalCharacter(
            name: "Aegina", title: "Island Nymph",
            description: "A Naiad daughter of the river Asopus abducted by Zeus.", tags: [.nymph],
            level: 8,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 12, perception: 14, luck: 10, willpower: 14),
            abilities: [.islandFortress]),
        // 26. Aegipan
        MythologicalCharacter(
            name: "Aegipan", title: "Goat-Fish God",
            description: "The fish-goat god who helped Zeus against Typhon.",
            tags: [.rustic, .sea], level: 12,
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 16, speed: 16, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 14, perception: 16, luck: 14, willpower: 12),
            abilities: [.panicCry]),
        // 27. Aegle (1)
        MythologicalCharacter(
            name: "Aegle (1)", title: "Goddess of Health",
            description: "Goddess of the splendour of good health.", tags: [.healing], level: 10,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 12, speed: 12, intelligence: 14, wisdom: 16,
                dexterity: 14, constitution: 12, perception: 14, luck: 14, willpower: 14),
            abilities: [.radiantHealth]),
        // 28. Aegle (2)
        MythologicalCharacter(
            name: "Aegle (2)", title: "Grace Nymph",
            description: "The nymph mother of the Charites (Graces).", tags: [.nymph], level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 10),
            abilities: [.radiantHealth]),
        // 29. Aello
        MythologicalCharacter(
            name: "Aello", title: "Storm Swift", description: "One of the Harpies.",
            tags: [.bestiary, .wind], level: 11,
            baseAttributes: Attributes(
                strength: 14, endurance: 12, agility: 20, speed: 22, intelligence: 10, wisdom: 10,
                dexterity: 18, constitution: 12, perception: 18, luck: 10, willpower: 12),
            abilities: [.stormSnatch]),
        // 30. Aeolus
        MythologicalCharacter(
            name: "Aeolus", title: "King of Winds",
            description:
                "The god of the winds who kept the storm-winds locked inside the floating island of Aeolia.",
            tags: [.wind, .titan], level: 18,
            baseAttributes: Attributes(
                strength: 16, endurance: 16, agility: 20, speed: 20, intelligence: 20, wisdom: 18,
                dexterity: 18, constitution: 16, perception: 22, luck: 16, willpower: 18),
            abilities: [.bagOfWinds]),
        // 31. Aeon
        MythologicalCharacter(
            name: "Aeon", title: "Time", description: "The primordial god of time.",
            tags: [.primordial], level: 20,
            baseAttributes: Attributes(
                strength: 20, endurance: 25, agility: 20, speed: 20, intelligence: 25, wisdom: 25,
                dexterity: 20, constitution: 25, perception: 25, luck: 20, willpower: 25),
            abilities: [.eternalCycle]),
        // 32. Aergia
        MythologicalCharacter(
            name: "Aergia", title: "Sloth", description: "The female personification of sloth.",
            tags: [.daemon, .personification], level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 6, speed: 6, intelligence: 10, wisdom: 8,
                dexterity: 6, constitution: 10, perception: 8, luck: 10, willpower: 14),
            abilities: [.lethargy]),
        // 33. Aether
        MythologicalCharacter(
            name: "Aether", title: "Upper Air",
            description: "The primordial deity of the brightly shining, blue upper air.",
            tags: [.primordial, .sky], level: 20,  // Uses .sky
            baseAttributes: Attributes(
                strength: 20, endurance: 25, agility: 25, speed: 25, intelligence: 25, wisdom: 25,
                dexterity: 25, constitution: 25, perception: 25, luck: 25, willpower: 25),
            abilities: [.pureLight]),
        // 34. Aetna
        MythologicalCharacter(
            name: "Aetna", title: "Volcano Goddess",
            description: "Goddess of the volcanic Mount Etna in Sicily.",
            tags: [.rustic, .mountain], level: 14,
            baseAttributes: Attributes(
                strength: 18, endurance: 20, agility: 8, speed: 8, intelligence: 12, wisdom: 14,
                dexterity: 8, constitution: 20, perception: 14, luck: 10, willpower: 18),
            abilities: [.volcanicEruption]),
        // 35. Aex (1)
        MythologicalCharacter(
            name: "Aex (1)", title: "Pan's Wife",
            description: "The goat-nymph wife of the god Pan.", tags: [.nymph, .rustic], level: 8,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 14, speed: 14, intelligence: 10, wisdom: 12,
                dexterity: 12, constitution: 12, perception: 14, luck: 12, willpower: 10),
            abilities: [.panicCry]),
        // 36. Aex (2)
        MythologicalCharacter(
            name: "Aex (2)", title: "Gorgoneion",
            description:
                "An elder Gorgon slain by Zeus who made his aegis arm-guard from its skin.",
            tags: [.bestiary], level: 15,
            baseAttributes: Attributes(
                strength: 18, endurance: 18, agility: 14, speed: 14, intelligence: 10, wisdom: 10,
                dexterity: 12, constitution: 18, perception: 14, luck: 8, willpower: 16),
            abilities: [.shieldBash]),
        // 37. Aganippe
        MythologicalCharacter(
            name: "Aganippe", title: "Spring of Inspiration",
            description: "A Naiad nymph of the sacred spring of the Muses on Mount Helicon.",
            tags: [.nymph], level: 8,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 14, wisdom: 16,
                dexterity: 14, constitution: 10, perception: 16, luck: 14, willpower: 12),
            abilities: [.musesDrink]),
        // 38. Agdistis
        MythologicalCharacter(
            name: "Agdistis", title: "Daemon of Madness",
            description: "An hermraphroditic deity whose castration created the goddess Cybele.",
            tags: [.daemon], level: 16,
            baseAttributes: Attributes(
                strength: 20, endurance: 20, agility: 16, speed: 16, intelligence: 14, wisdom: 10,
                dexterity: 16, constitution: 20, perception: 18, luck: 10, willpower: 18),
            abilities: [.wildFrenzy]),
        // 39. Aglaea
        MythologicalCharacter(
            name: "Aglaea", title: "Charis of Glory",
            description: "Goddess of beauty and one of the three Charites.",
            tags: [.olympian, .personification], level: 14,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 16, speed: 16, intelligence: 16, wisdom: 18,
                dexterity: 18, constitution: 12, perception: 18, luck: 18, willpower: 14),
            abilities: [.splendour]),
        // 40. Agon
        MythologicalCharacter(
            name: "Agon", title: "Contest", description: "The male personification of contest.",
            tags: [.daemon, .personification], level: 8,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 14, speed: 14, intelligence: 10, wisdom: 10,
                dexterity: 14, constitution: 14, perception: 12, luck: 12, willpower: 14),
            abilities: [.challenge]),
        // 41. Agreus
        MythologicalCharacter(
            name: "Agreus", title: "Hunter/Fisher God", description: "The marine god of fishing.",
            tags: [.rustic], level: 10,
            baseAttributes: Attributes(
                strength: 12, endurance: 12, agility: 14, speed: 14, intelligence: 12, wisdom: 14,
                dexterity: 16, constitution: 12, perception: 18, luck: 14, willpower: 12),
            abilities: [.rusticTrap]),
        // 42. Agrius (1)
        MythologicalCharacter(
            name: "Agrius (1)", title: "Gigante",
            description: "One of the Gigantes clubbed to death by the Moirae.", tags: [.giant],
            level: 14,
            baseAttributes: Attributes(
                strength: 22, endurance: 20, agility: 10, speed: 10, intelligence: 8, wisdom: 8,
                dexterity: 10, constitution: 22, perception: 10, luck: 8, willpower: 16),
            abilities: [.giantCrush]),
        // 43. Agrius (2)
        MythologicalCharacter(
            name: "Agrius (2)", title: "Man-Eater",
            description:
                "One of a pair of half-man, half-bear, Thracian giants who fed on the flesh of men.",
            tags: [.giant], level: 14,
            baseAttributes: Attributes(
                strength: 24, endurance: 22, agility: 12, speed: 12, intelligence: 6, wisdom: 6,
                dexterity: 12, constitution: 24, perception: 14, luck: 6, willpower: 14),
            abilities: [.manEatingBite]),
        // 44. Agros
        MythologicalCharacter(
            name: "Agros", title: "Divine Field",
            description: "The male personification of the produce of the fields.", tags: [.rustic],
            level: 8,
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 10, speed: 10, intelligence: 10, wisdom: 12,
                dexterity: 10, constitution: 14, perception: 10, luck: 12, willpower: 12),
            abilities: [.rusticTrap]),
    ]
}
