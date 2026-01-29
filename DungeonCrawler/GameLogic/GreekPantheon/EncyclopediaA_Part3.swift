import Foundation

extension EncyclopediaA {
    static let part3: [MythologicalCharacter] = [
        // 90. Antheia
        MythologicalCharacter(
            name: "Antheia", title: "Flowers", description: "The goddess of flowers and swamps.",
            tags: [.nymph, .personification], level: 10,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 12, wisdom: 14,
                dexterity: 12, constitution: 10, perception: 16, luck: 14, willpower: 12),
            abilities: [.springGrowth]),
        // 91. Anthedon
        MythologicalCharacter(
            name: "Anthedon", title: "Boeotian Nymph",
            description: "A Naiad nymph of the town of Anthedon.", tags: [.nymph], level: 6,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 12, intelligence: 10, wisdom: 10,
                dexterity: 12, constitution: 10, perception: 12, luck: 12, willpower: 10),
            abilities: [.heal]),
        // 92. Anthracia
        MythologicalCharacter(
            name: "Anthracia", title: "Arcadian Nymph",
            description: "An Arcadian nymph who was one of the nurses of Zeus.",
            tags: [.nymph, .rustic], level: 6,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 12, intelligence: 10, wisdom: 10,
                dexterity: 12, constitution: 10, perception: 12, luck: 12, willpower: 10),
            abilities: [.nursesCare]),
        // 93. Antiphates
        MythologicalCharacter(
            name: "Antiphates", title: "King of Laestrygones",
            description: "King of the man-eating Laestrygonian giants.", tags: [.giant], level: 15,
            baseAttributes: Attributes(
                strength: 22, endurance: 20, agility: 12, speed: 12, intelligence: 10, wisdom: 10,
                dexterity: 12, constitution: 22, perception: 14, luck: 10, willpower: 16),
            abilities: [.giantCrush]),
        // 94. Anytus
        MythologicalCharacter(
            name: "Anytos", title: "Titan Foster-Father",
            description: "A Titan attendant of the goddess Despoine.", tags: [.titan], level: 16,
            baseAttributes: Attributes(
                strength: 20, endurance: 20, agility: 12, speed: 12, intelligence: 14, wisdom: 16,
                dexterity: 12, constitution: 20, perception: 16, luck: 12, willpower: 18),
            abilities: [.earthRegen]),
        // 95. Apate
        MythologicalCharacter(
            name: "Apate", title: "Deceit",
            description: "The female personification of deceit and guile.",
            tags: [.daemon, .personification], level: 12,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 16, speed: 16, intelligence: 18, wisdom: 14,
                dexterity: 18, constitution: 10, perception: 18, luck: 16, willpower: 12),
            abilities: [.falseImage]),
        // 96. Apeliotes
        MythologicalCharacter(
            name: "Apeliotes", title: "East Wind", description: "The god of the east wind.",
            tags: [.wind], level: 14,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 18, speed: 18, intelligence: 14, wisdom: 14,
                dexterity: 16, constitution: 14, perception: 16, luck: 12, willpower: 14),
            abilities: [.swiftness]),
        // 97. Aphrodite
        MythologicalCharacter(
            name: "Aphrodite", title: "Goddess of Love",
            description: "Olympian goddess of beauty, love, pleasure and procreation.",
            tags: [.olympian], level: 20,
            baseAttributes: Attributes(
                strength: 14, endurance: 16, agility: 18, speed: 18, intelligence: 18, wisdom: 20,
                dexterity: 18, constitution: 18, perception: 22, luck: 25, willpower: 22),
            abilities: [.charmPerson, .dovesGrace, .splendour]),
        // 98. Aphros
        MythologicalCharacter(
            name: "Aphros", title: "Sea Centaur", description: "An Ichthyocentaur (sea-centaur).",
            tags: [.sea, .bestiary], level: 10,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 14, speed: 16, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 14, perception: 14, luck: 12, willpower: 12),
            abilities: [.seaStorm]),
        // 99. Aporia
        MythologicalCharacter(
            name: "Aporia", title: "Difficulty",
            description: "The personification of difficulty and want of means.", tags: [.daemon],
            level: 6,
            baseAttributes: Attributes(
                strength: 6, endurance: 8, agility: 6, speed: 6, intelligence: 8, wisdom: 8,
                dexterity: 6, constitution: 8, perception: 8, luck: 6, willpower: 8),
            abilities: [.despair]),
        // 100. Apotheothenai
        MythologicalCharacter(
            name: "Apotheothenai", title: "Deified Mortal",
            description: "Women who were deified after death.", tags: [.deified, .hero], level: 12,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 14, constitution: 14, perception: 14, luck: 14, willpower: 14),
            abilities: [.battleProwess]),
        // 101. Arae
        MythologicalCharacter(
            name: "Arae", title: "Curses", description: "Daemones of curses.",
            tags: [.daemon, .underworld], level: 12,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 12, speed: 12, intelligence: 14, wisdom: 14,
                dexterity: 12, constitution: 12, perception: 16, luck: 8, willpower: 16),
            abilities: [.bloodFeud]),
        // 102. Arce
        MythologicalCharacter(
            name: "Arce", title: "Fallen Messenger", description: "The messenger of the Titans.",
            tags: [.titan, .wind], level: 14,
            baseAttributes: Attributes(
                strength: 12, endurance: 12, agility: 20, speed: 20, intelligence: 14, wisdom: 12,
                dexterity: 18, constitution: 12, perception: 16, luck: 8, willpower: 14),
            abilities: [.swiftMessage]),
        // 103. Ares
        MythologicalCharacter(
            name: "Ares", title: "God of War",
            description: "Olympian god of war, battlelust, courage and civil order.",
            tags: [.olympian], level: 20,
            baseAttributes: Attributes(
                strength: 25, endurance: 24, agility: 18, speed: 18, intelligence: 16, wisdom: 14,
                dexterity: 20, constitution: 24, perception: 18, luck: 12, willpower: 22),
            abilities: [.godOfWar, .bloodshed]),
        // 104. Arete
        MythologicalCharacter(
            name: "Arete", title: "Virtue", description: "The personification of virtue.",
            tags: [.personification], level: 12,
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 14, speed: 14, intelligence: 16, wisdom: 18,
                dexterity: 14, constitution: 14, perception: 16, luck: 14, willpower: 18),
            abilities: [.battleProwess]),
        // 105. Arethusa
        MythologicalCharacter(
            name: "Arethusa", title: "Spring Nymph",
            description: "A Naiad nymph of the spring Arethusa in Syracuse.",
            tags: [.nymph, .river], level: 9,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 16, speed: 16, intelligence: 12, wisdom: 12,
                dexterity: 14, constitution: 10, perception: 14, luck: 12, willpower: 12),
            abilities: [.sicilianSpring]),
        // 106. Arges
        MythologicalCharacter(
            name: "Arges", title: "Thunderbolt Cyclops",
            description: "One of the three Cyclopes, makers of Zeus' thunderbolts.", tags: [.giant],
            level: 15,
            baseAttributes: Attributes(
                strength: 22, endurance: 20, agility: 10, speed: 10, intelligence: 14, wisdom: 12,
                dexterity: 14, constitution: 20, perception: 12, luck: 10, willpower: 16),
            abilities: [.lightningBolt]),
        // 107. Argiope (1)
        MythologicalCharacter(
            name: "Argiope (1)", title: "Parnassian Nymph",
            description: "A nymph of Mount Parnassus.", tags: [.nymph, .rustic], level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 10),
            abilities: [.heal]),
        // 108. Argiope (2)
        MythologicalCharacter(
            name: "Argiope (2)", title: "Eleusinian Nymph", description: "An Eleusinian nymph.",
            tags: [.nymph, .rustic], level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 10),
            abilities: [.springGrowth]),
        // 109. Argus Panoptes
        MythologicalCharacter(
            name: "Argus Panoptes", title: "All-Seeing Giant",
            description: "A hundred-eyed giant tasked with guarding Io.", tags: [.giant], level: 16,
            baseAttributes: Attributes(
                strength: 24, endurance: 22, agility: 12, speed: 12, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 22, perception: 25, luck: 10, willpower: 18),
            abilities: [.hundredEyesWatch, .giantSmash]),
        // 110. Argyra
        MythologicalCharacter(
            name: "Argyra", title: "Sea Nymph", description: "A sea nymph.", tags: [.nymph, .sea],
            level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 10),
            abilities: [.heal]),
        // 111. Ariadne
        MythologicalCharacter(
            name: "Ariadne", title: "Wife of Dionysus",
            description: "Wife of Dionysus, the god of wine.", tags: [.deified, .hero], level: 14,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 14, speed: 14, intelligence: 16, wisdom: 16,
                dexterity: 14, constitution: 14, perception: 16, luck: 18, willpower: 16),
            abilities: [.goldenThread]),
        // 112. Arimaspians
        MythologicalCharacter(
            name: "Arimaspians", title: "One-Eyed Tribe", description: "A tribe of one-eyed men.",
            tags: [.bestiary], level: 8,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 12, speed: 12, intelligence: 10, wisdom: 10,
                dexterity: 12, constitution: 14, perception: 14, luck: 10, willpower: 12),
            abilities: [.spearThrust]),
        // 113. Arion
        MythologicalCharacter(
            name: "Arion", title: "Immortal Horse",
            description: "An immortal horse born of Demeter and Poseidon.", tags: [.bestiary],
            level: 12,
            baseAttributes: Attributes(
                strength: 18, endurance: 20, agility: 22, speed: 25, intelligence: 10, wisdom: 12,
                dexterity: 14, constitution: 20, perception: 16, luck: 15, willpower: 14),
            abilities: [.horseKick, .immortalStamina]),
        // 114. Aristaeus (1)
        MythologicalCharacter(
            name: "Aristaeus (1)", title: "Rustic God",
            description:
                "The rustic god of shepherds, cheese-making, beekeeping, honey, and olive-growing.",
            tags: [.rustic, .deified], level: 14,
            baseAttributes: Attributes(
                strength: 16, endurance: 16, agility: 14, speed: 14, intelligence: 18, wisdom: 20,
                dexterity: 16, constitution: 16, perception: 18, luck: 14, willpower: 16),
            abilities: [.beeSwarm]),
        // 115. Aristaeus (2)
        MythologicalCharacter(
            name: "Aristaeus (2)", title: "Gigante", description: "One of the Gigantes.",
            tags: [.giant], level: 13,
            baseAttributes: Attributes(
                strength: 22, endurance: 20, agility: 8, speed: 8, intelligence: 6, wisdom: 6,
                dexterity: 8, constitution: 20, perception: 10, luck: 6, willpower: 12),
            abilities: [.giantCrush, .dungBeetleForm]),
        // 116. Artemis
        MythologicalCharacter(
            name: "Artemis", title: "Goddess of the Hunt",
            description: "Olympian goddess of hunting, wilderness and wild animals.",
            tags: [.olympian], level: 20,
            baseAttributes: Attributes(
                strength: 18, endurance: 20, agility: 25, speed: 24, intelligence: 20, wisdom: 22,
                dexterity: 25, constitution: 20, perception: 25, luck: 15, willpower: 20),
            abilities: [.moonArrow, .wildShape, .aimedShot]),
        // 117. Asbeton
        MythologicalCharacter(
            name: "Asbeton", title: "Daemon of Charr",
            description: "A daemon of the charring of pottery.", tags: [.daemon], level: 6,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 10, speed: 10, intelligence: 8, wisdom: 8,
                dexterity: 10, constitution: 12, perception: 10, luck: 6, willpower: 10),
            abilities: [.kilnFire]),
        // 118. Ascalaphus
        MythologicalCharacter(
            name: "Ascalaphus", title: "Orchard Spirit", description: "The orchardist of Hades.",
            tags: [.daemon, .underworld], level: 9,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 14, speed: 14, intelligence: 14, wisdom: 12,
                dexterity: 12, constitution: 12, perception: 16, luck: 5, willpower: 10),
            abilities: [.owlShriek, .pomegranateCurse]),
        // 119. Ascanius
        MythologicalCharacter(
            name: "Ascanius", title: "Mysian River", description: "A Mysian river and its god.",
            tags: [.river], level: 10,
            baseAttributes: Attributes(
                strength: 15, endurance: 16, agility: 12, speed: 12, intelligence: 12, wisdom: 14,
                dexterity: 10, constitution: 16, perception: 14, luck: 10, willpower: 12),
            abilities: [.mysianCurrent]),
        // 120. Asclepius
        MythologicalCharacter(
            name: "Asclepius", title: "God of Medicine", description: "The god of medicine.",
            tags: [.olympian, .healing], level: 16,
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 14, speed: 14, intelligence: 24, wisdom: 25,
                dexterity: 18, constitution: 14, perception: 20, luck: 12, willpower: 18),
            abilities: [.panacea, .serpentStaff]),
        // 121. Ascra
        MythologicalCharacter(
            name: "Ascra", title: "Boeotian Nymph", description: "A Boeotian nymph.",
            tags: [.nymph], level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 12, intelligence: 14, wisdom: 14,
                dexterity: 12, constitution: 10, perception: 14, luck: 10, willpower: 12),
            abilities: [.poeticInspiration]),
        // 122. Asia (1)
        MythologicalCharacter(
            name: "Asia (1)", title: "Oceanid", description: "The Oceanid nymph of Asia.",
            tags: [.titan], level: 14,
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 12, speed: 12, intelligence: 16, wisdom: 18,
                dexterity: 12, constitution: 14, perception: 16, luck: 12, willpower: 16),
            abilities: [.forethoughtGift]),
        // 123. Asia (2)
        MythologicalCharacter(
            name: "Asia (2)", title: "Prometheus' Wife",
            description: "Wife of the Titan Prometheus.", tags: [.nymph], level: 10,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 12, speed: 12, intelligence: 14, wisdom: 16,
                dexterity: 12, constitution: 12, perception: 14, luck: 12, willpower: 14),
            abilities: [.forethoughtGift]),
        // 124. Asopis
        MythologicalCharacter(
            name: "Asopis", title: "River Daughter",
            description: "A Naiad daughter of the river Asopus.", tags: [.nymph, .river], level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 10),
            abilities: [.riverSurge]),
        // 125. Asopus
        MythologicalCharacter(
            name: "Asopus", title: "Boeotian River", description: "A river of Boeotia and its god.",
            tags: [.river], level: 14,
            baseAttributes: Attributes(
                strength: 18, endurance: 18, agility: 12, speed: 12, intelligence: 14, wisdom: 14,
                dexterity: 12, constitution: 18, perception: 16, luck: 8, willpower: 16),
            abilities: [.boeotianFlood]),
        // 126. Asteria
        MythologicalCharacter(
            name: "Asteria", title: "Starry One",
            description: "Titan-goddess of the stars and the night.", tags: [.titan, .star],
            level: 16,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 18, speed: 18, intelligence: 18, wisdom: 18,
                dexterity: 16, constitution: 14, perception: 20, luck: 12, willpower: 18),
            abilities: [.starFall, .quailFlight]),
        // 127. Asterion
        MythologicalCharacter(
            name: "Asterion", title: "Argive River", description: "A river of Argos and its god.",
            tags: [.river], level: 10,
            baseAttributes: Attributes(
                strength: 14, endurance: 16, agility: 12, speed: 12, intelligence: 12, wisdom: 14,
                dexterity: 10, constitution: 16, perception: 14, luck: 12, willpower: 12),
            abilities: [.argiveFlow]),
        // 128. Asterius
        MythologicalCharacter(
            name: "Asterius", title: "Lydian Giant", description: "A Lydian giant.", tags: [.giant],
            level: 14,
            baseAttributes: Attributes(
                strength: 22, endurance: 22, agility: 10, speed: 10, intelligence: 8, wisdom: 8,
                dexterity: 10, constitution: 22, perception: 12, luck: 10, willpower: 14),
            abilities: [.giantCrush]),
        // 129. Asterodeia
        MythologicalCharacter(
            name: "Asterodeia", title: "Caucasian Nymph", description: "A Caucasian nymph.",
            tags: [.nymph], level: 8,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 14, speed: 14, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 12, perception: 14, luck: 12, willpower: 12),
            abilities: [.caucasianFrost]),
        // 130. Asterope
        MythologicalCharacter(
            name: "Asterope", title: "Star Nymph", description: "A star-nymph.",
            tags: [.nymph, .star], level: 9,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 16, speed: 16, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 10, perception: 16, luck: 14, willpower: 12),
            abilities: [.starNymphLight]),
        // 131. Astra Planeta
        MythologicalCharacter(
            name: "Astra Planeta", title: "Wandering Stars",
            description: "The gods of the five wandering stars (planets).", tags: [.star],
            level: 15,
            baseAttributes: Attributes(
                strength: 14, endurance: 14, agility: 18, speed: 20, intelligence: 18, wisdom: 16,
                dexterity: 16, constitution: 14, perception: 18, luck: 14, willpower: 16),
            abilities: [.planetaryOrbit]),
        // 132. Astraea
        MythologicalCharacter(
            name: "Astraea", title: "Justice", description: "The virgin goddess of justice.",
            tags: [.titan, .star], level: 16,
            baseAttributes: Attributes(
                strength: 14, endurance: 16, agility: 16, speed: 16, intelligence: 20, wisdom: 22,
                dexterity: 16, constitution: 16, perception: 22, luck: 14, willpower: 20),
            abilities: [.justiceStrike]),
        // 133. Astraeus (1)
        MythologicalCharacter(
            name: "Astraeus (1)", title: "Titan of Stars",
            description: "The Titan-god of the stars and planets.", tags: [.titan, .star],
            level: 17,
            baseAttributes: Attributes(
                strength: 18, endurance: 18, agility: 16, speed: 16, intelligence: 20, wisdom: 20,
                dexterity: 16, constitution: 18, perception: 20, luck: 14, willpower: 18),
            abilities: [.windGust, .starFall]),
        // 134. Astraeus (2)
        MythologicalCharacter(
            name: "Astraeus (2)", title: "Silen", description: "A Silen.", tags: [.rustic],
            level: 8,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 12, speed: 12, intelligence: 12, wisdom: 14,
                dexterity: 12, constitution: 12, perception: 12, luck: 12, willpower: 10),
            abilities: [.intoxication]),
        // 135. Astrape
        MythologicalCharacter(
            name: "Astrape", title: "Lightning", description: "The goddess of lightning.",
            tags: [.personification], level: 12,
            baseAttributes: Attributes(
                strength: 14, endurance: 12, agility: 20, speed: 22, intelligence: 14, wisdom: 12,
                dexterity: 18, constitution: 12, perception: 16, luck: 14, willpower: 14),
            abilities: [.lightningBolt]),
        // 136. Astris
        MythologicalCharacter(
            name: "Astris", title: "Star Nymph", description: "A star-nymph daughter of Helios.",
            tags: [.nymph, .star], level: 9,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 16, speed: 16, intelligence: 14, wisdom: 14,
                dexterity: 14, constitution: 10, perception: 16, luck: 14, willpower: 12),
            abilities: [.starNymphLight]),
        // 137. Astrothesiai
        MythologicalCharacter(
            name: "Astrothesiai", title: "Constellations", description: "The constellations.",
            tags: [.star], level: 14,
            baseAttributes: Attributes(
                strength: 14, endurance: 16, agility: 10, speed: 10, intelligence: 16, wisdom: 18,
                dexterity: 12, constitution: 16, perception: 18, luck: 14, willpower: 18),
            abilities: [.constellationForm]),
        // 138. Astyoche
        MythologicalCharacter(
            name: "Astyoche", title: "Trojan Nymph", description: "A Trojan nymph.",
            tags: [.nymph, .river], level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 12, speed: 12, intelligence: 12, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 12, luck: 12, willpower: 10),
            abilities: [.heal]),
        // 139. Ate
        MythologicalCharacter(
            name: "Ate", title: "Ruin",
            description: "The female personification of ruin and folly.", tags: [.daemon],
            level: 14,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 16, speed: 16, intelligence: 16, wisdom: 10,
                dexterity: 16, constitution: 12, perception: 14, luck: 5, willpower: 16),
            abilities: [.blindFolly, .ruinousDelusion]),
        // 140. Athena
        MythologicalCharacter(
            name: "Athena", title: "Goddess of Strategy",
            description: "Olympian goddess of wisdom, war, weaving, pottery and the crafts.",
            tags: [.olympian], level: 20,
            baseAttributes: Attributes(
                strength: 20, endurance: 22, agility: 20, speed: 20, intelligence: 25, wisdom: 25,
                dexterity: 22, constitution: 22, perception: 25, luck: 18, willpower: 24),
            abilities: [.strategy, .aegisDeflect, .shieldBash]),
        // 141. Atlanteia
        MythologicalCharacter(
            name: "Atlanteia", title: "Hamadryad", description: "A Hamadryad nymph.",
            tags: [.nymph], level: 8,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 12, speed: 12, intelligence: 10, wisdom: 12,
                dexterity: 12, constitution: 12, perception: 14, luck: 12, willpower: 10),
            abilities: [.treeBarkSkin]),
        // 142. Atlantis
        MythologicalCharacter(
            name: "Atlantis", title: "Lost Continent", description: "A legendary lost continent.",
            tags: [.personification], level: 18,
            baseAttributes: Attributes(
                strength: 22, endurance: 24, agility: 10, speed: 10, intelligence: 20, wisdom: 20,
                dexterity: 10, constitution: 24, perception: 18, luck: 5, willpower: 18),
            abilities: [.sunkenWrath]),
        // 143. Atlas
        MythologicalCharacter(
            name: "Atlas", title: "Titan of Endurance",
            description: "The Titan-god of endurance and astronomy.", tags: [.titan], level: 19,
            baseAttributes: Attributes(
                strength: 25, endurance: 25, agility: 10, speed: 10, intelligence: 18, wisdom: 20,
                dexterity: 10, constitution: 25, perception: 18, luck: 10, willpower: 25),
            abilities: [.skyBurden]),
        // 144. Atropus
        MythologicalCharacter(
            name: "Atropus", title: "Inevitable Fate",
            description: "One of the three Moirai (Fates).", tags: [.daemon], level: 20,
            baseAttributes: Attributes(
                strength: 10, endurance: 20, agility: 10, speed: 10, intelligence: 25, wisdom: 25,
                dexterity: 10, constitution: 20, perception: 25, luck: 25, willpower: 25),
            abilities: [.fateCut]),
        // 145. Attis
        MythologicalCharacter(
            name: "Attis", title: "Consort of Cybele",
            description: "The eunuch consort of the goddess Cybele.", tags: [.hero], level: 12,
            baseAttributes: Attributes(
                strength: 12, endurance: 14, agility: 16, speed: 16, intelligence: 12, wisdom: 12,
                dexterity: 16, constitution: 14, perception: 14, luck: 10, willpower: 12),
            abilities: [.frenziedDance]),
        // 146. Auge
        MythologicalCharacter(
            name: "Auge", title: "First Light", description: "Goddess of the first light of dawn.",
            tags: [.personification], level: 10,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 14, wisdom: 14,
                dexterity: 12, constitution: 10, perception: 18, luck: 14, willpower: 12),
            abilities: [.dawnLight]),
        // 147. Auloniades
        MythologicalCharacter(
            name: "Auloniades", title: "Glen Nymphs", description: "Nymphs of the glens.",
            tags: [.nymph, .rustic], level: 7,
            baseAttributes: Attributes(
                strength: 8, endurance: 10, agility: 14, speed: 14, intelligence: 10, wisdom: 12,
                dexterity: 12, constitution: 10, perception: 14, luck: 12, willpower: 10),
            abilities: [.glenWhisper]),
        // 148. Aura
        MythologicalCharacter(
            name: "Aura", title: "Breeze", description: "The goddess of the breeze.",
            tags: [.wind, .titan], level: 12,
            baseAttributes: Attributes(
                strength: 10, endurance: 10, agility: 20, speed: 20, intelligence: 12, wisdom: 10,
                dexterity: 18, constitution: 10, perception: 16, luck: 12, willpower: 12),
            abilities: [.windGust]),
        // 149. Aurae
        MythologicalCharacter(
            name: "Aurae", title: "Nymphs of Breeze", description: "Nymphs of the breeze.",
            tags: [.wind, .nymph], level: 8,
            baseAttributes: Attributes(
                strength: 8, endurance: 8, agility: 18, speed: 18, intelligence: 10, wisdom: 10,
                dexterity: 16, constitution: 8, perception: 14, luck: 12, willpower: 10),
            abilities: [.windGust]),
        // 150. Automatones
        MythologicalCharacter(
            name: "Automatones", title: "Living Statues",
            description: "Living statues and metal automatons.", tags: [.bestiary], level: 14,
            baseAttributes: Attributes(
                strength: 22, endurance: 22, agility: 8, speed: 8, intelligence: 5, wisdom: 5,
                dexterity: 10, constitution: 24, perception: 10, luck: 10, willpower: 20),
            abilities: [.automatonCrush, .metalBody]),
        // 151. Auxesia
        MythologicalCharacter(
            name: "Auxesia", title: "Growth", description: "Goddess of the growth of plants.",
            tags: [.personification], level: 10,
            baseAttributes: Attributes(
                strength: 10, endurance: 12, agility: 12, speed: 12, intelligence: 12, wisdom: 14,
                dexterity: 12, constitution: 12, perception: 14, luck: 14, willpower: 12),
            abilities: [.growthSurge]),
        // 152. Axius
        MythologicalCharacter(
            name: "Axius", title: "Paeonian River", description: "A river of Paeonia and its god.",
            tags: [.river], level: 16,
            baseAttributes: Attributes(
                strength: 20, endurance: 20, agility: 14, speed: 14, intelligence: 14, wisdom: 16,
                dexterity: 12, constitution: 20, perception: 16, luck: 12, willpower: 16),
            abilities: [.paeonianSurge]),
    ]
}
