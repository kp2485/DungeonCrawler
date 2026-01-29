import Foundation

extension Ability {
    // MARK: - Achelous (River God)
    static let hornStrike = Ability(
        name: "Horn Strike", description: "Strike with a river-bull horn.", manaCost: 15,
        type: .damage, power: 25, attributeScaling: .strength, diceRoll: "2d10",
        damageType: .physical, targetType: .singleEnemy
    )
    static let riverWrestling = Ability(
        name: "River Wrestling", description: "Grapple and drown the enemy.", manaCost: 20,
        type: .damage, power: 30, attributeScaling: .strength, diceRoll: "3d8", damageType: .water,
        targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .stun, duration: 1, chance: 0.5)]
    )

    // MARK: - Aba (Nymph)
    static let thracianCharm = Ability(
        name: "Thracian Charm", description: "Allure of a Thracian nymph.", manaCost: 10,
        type: .debuff, power: 0, attributeScaling: .luck, diceRoll: "1d6", damageType: .psychic,
        targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .charm, duration: 2, chance: 0.75)]
    )

    // MARK: - Abarbaree (Naiad)
    static let bucolicGrace = Ability(
        name: "Bucolic Grace", description: "Grace of the shepherd lands.", manaCost: 10,
        type: .heal, power: 15, attributeScaling: .wisdom, diceRoll: "2d6", damageType: .radiant,
        targetType: .singleAlly
    )

    // MARK: - Aceso (Healing Goddess)
    static let curingTouch = Ability(
        name: "Curing Touch", description: "Process of curing illness.", manaCost: 20,
        type: .heal, power: 25, attributeScaling: .wisdom, diceRoll: "3d6", damageType: .radiant,
        targetType: .singleAlly,
        statusEffects: [StatusEffectDefinition(type: .regeneration, duration: 3, magnitude: 5)]
    )

    // MARK: - Acheloides (Naiads)
    static let sirenSong = Ability(
        name: "Siren Song", description: "Lure enemies into danger.", manaCost: 20,
        type: .debuff, power: 10, attributeScaling: .luck, diceRoll: "1d8", damageType: .psychic,
        targetType: .allEnemies,
        statusEffects: [StatusEffectDefinition(type: .charm, duration: 1, chance: 0.5)]
    )

    // MARK: - Acheron (River of Pain)
    static let riverOfPain = Ability(
        name: "River of Pain", description: "Inflict spiritual agony.", manaCost: 30,
        type: .damage, power: 35, attributeScaling: .willpower, diceRoll: "4d8",
        damageType: .necrotic, targetType: .allEnemies,
        statusEffects: [StatusEffectDefinition(type: .fear, duration: 2, chance: 0.4)]
    )

    // MARK: - Achlys (Death Mist)
    static let deathMist = Ability(
        name: "Death Mist", description: "Cloud eyes with the mist of death.", manaCost: 40,
        type: .debuff, power: 50, attributeScaling: .willpower, diceRoll: "1d100",
        damageType: .necrotic, targetType: .allEnemies, cooldown: 5,
        statusEffects: [StatusEffectDefinition(type: .accuracyDown, duration: 3, magnitude: 5)]
    )

    // MARK: - Acis (River Spirit)
    static let sicilianSpring = Ability(
        name: "Sicilian Spring", description: "Transform into water to evade.", manaCost: 15,
        type: .buff, power: 10, attributeScaling: .agility, diceRoll: "1d6", damageType: .water,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .evasionUp, duration: 2, magnitude: 3)]
    )

    // MARK: - Acmon (Dactyl / Cercopes)
    static let anvilStrike = Ability(
        name: "Anvil Strike", description: "Strike as hard as an anvil.", manaCost: 15,
        type: .damage, power: 20, attributeScaling: .strength, diceRoll: "2d8",
        damageType: .physical, targetType: .singleEnemy
    )
    static let monkeyTrick = Ability(
        name: "Monkey Trick", description: "Confuse and steal.", manaCost: 10,
        type: .utility, power: 5, attributeScaling: .luck, diceRoll: "1d4", damageType: .psychic,
        targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .confusion, duration: 1, chance: 0.5)]
    )

    // MARK: - Acraea (Nurse of Hera)
    static let nursesCare = Ability(
        name: "Nurse's Care", description: "Protective ward.", manaCost: 15,
        type: .buff, power: 15, attributeScaling: .wisdom, diceRoll: "2d6", damageType: .radiant,
        targetType: .singleAlly,
        statusEffects: [StatusEffectDefinition(type: .defenseUp, duration: 3, magnitude: 2)]
    )

    // MARK: - Acratus (Unmixed Wine)
    static let intoxication = Ability(
        name: "Intoxication", description: "Confuse with potent wine.", manaCost: 15,
        type: .debuff, power: 10, attributeScaling: .constitution, diceRoll: "1d8",
        damageType: .poison, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .confusion, duration: 2, chance: 0.6)]
    )

    // MARK: - Acte (Agte - Hora)
    static let afternoonSun = Ability(
        name: "Afternoon Sun", description: "Blinding light of the afternoon.", manaCost: 15,
        type: .damage, power: 20, attributeScaling: .intelligence, diceRoll: "2d8",
        damageType: .fire, targetType: .allEnemies,
        statusEffects: [StatusEffectDefinition(type: .accuracyDown, duration: 1, magnitude: 2)]
    )

    // MARK: - Adephagia (Gluttony)
    static let ravenousHunger = Ability(
        name: "Ravenous Hunger", description: "Drain enemy stamina.", manaCost: 20,
        type: .damage, power: 15, attributeScaling: .constitution, diceRoll: "2d8",
        damageType: .necrotic, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .enduranceDown, duration: 3, magnitude: 2)]
    )

    // MARK: - Adicia (Injustice)
    static let unfairBlow = Ability(
        name: "Unfair Blow", description: "Strike when opponent is down.", manaCost: 10,
        type: .damage, power: 25, attributeScaling: .dexterity, diceRoll: "3d6",
        damageType: .physical, targetType: .singleEnemy
    )

    // MARK: - Adrasteia (Nemesis / Nymph)
    static let inevitableRetribution = Ability(
        name: "Inevitability", description: "Damage that cannot be dodged.", manaCost: 25,
        type: .damage, power: 30, attributeScaling: .wisdom, diceRoll: "3d8", damageType: .force,
        targetType: .singleEnemy
    )

    // MARK: - Aea (Nymph)
    static let colchisMagic = Ability(
        name: "Colchian Magic", description: "Ancient restorative spell.", manaCost: 25,
        type: .heal, power: 20, attributeScaling: .intelligence, diceRoll: "2d10",
        damageType: .force, targetType: .singleAlly,
        statusEffects: [StatusEffectDefinition(type: .regeneration, duration: 3, magnitude: 5)]
    )

    // MARK: - Aeacus (Judge)
    static let underworldJudgment = Ability(
        name: "Judgment", description: "Condemns the guilty.", manaCost: 40,
        type: .damage, power: 45, attributeScaling: .wisdom, diceRoll: "4d10", damageType: .radiant,
        targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .stun, duration: 1, chance: 0.4)]
    )
    static let antMyrmidons = Ability(
        name: "Myrmidon Call", description: "Summon ant-warriors.", manaCost: 35,
        type: .utility, power: 0, attributeScaling: .willpower, diceRoll: "1d1",
        damageType: .physical, targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .strengthUp, duration: 3, magnitude: 3)]
    )

    // MARK: - Aedos (Modesty)
    static let humbleAura = Ability(
        name: "Humble Aura", description: "Pacify enemies.", manaCost: 20,
        type: .debuff, power: 0, attributeScaling: .wisdom, diceRoll: "1d20", damageType: .psychic,
        targetType: .allEnemies,
        statusEffects: [StatusEffectDefinition(type: .strengthDown, duration: 2, magnitude: 2)]
    )

    // MARK: - Aegaeon (Hundred-Hander)
    static let hundredHandSlap = Ability(
        name: "Hundred Hand Slap", description: "Multiple strikes at once.", manaCost: 30,
        type: .damage, power: 40, attributeScaling: .strength, diceRoll: "10d4",
        damageType: .physical, targetType: .singleEnemy
    )

    // MARK: - Aegeirus (Poplar)
    static let poplarRustle = Ability(
        name: "Poplar Rustle", description: "Soothing sound of leaves.", manaCost: 10,
        type: .heal, power: 10, attributeScaling: .wisdom, diceRoll: "1d8", damageType: .nature,
        targetType: .allAllies,
        statusEffects: [StatusEffectDefinition(type: .regeneration, duration: 2, magnitude: 2)]
    )

    // MARK: - Aegina (Island Nymph)
    static let islandFortress = Ability(
        name: "Island Fortress", description: "Impenetrable defense.", manaCost: 25,
        type: .buff, power: 25, attributeScaling: .constitution, diceRoll: "3d8",
        damageType: .earth, targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .defenseUp, duration: 3, magnitude: 4)]
    )

    // MARK: - Aegipan (Goat-Fish)
    static let panicCry = Ability(
        name: "Panic Cry", description: "Cause fear in enemies.", manaCost: 20,
        type: .debuff, power: 10, attributeScaling: .willpower, diceRoll: "1d6", damageType: .sonic,
        targetType: .allEnemies,
        statusEffects: [StatusEffectDefinition(type: .fear, duration: 2, chance: 0.5)]
    )

    // MARK: - Aegle (Health)
    static let radiantHealth = Ability(
        name: "Radiant Health", description: "Restore vitality and cure ailments.", manaCost: 30,
        type: .heal, power: 30, attributeScaling: .wisdom, diceRoll: "4d6", damageType: .radiant,
        targetType: .singleAlly,
        statusEffects: [
            StatusEffectDefinition(type: .regeneration, duration: 3, magnitude: 5),
            StatusEffectDefinition(type: .constitutionUp, duration: 3, magnitude: 2),
        ]
    )

    // MARK: - Aello (Harpy)
    static let stormSnatch = Ability(
        name: "Storm Snatch", description: "Swoop down and steal/strike.", manaCost: 15,
        type: .damage, power: 20, attributeScaling: .agility, diceRoll: "2d8", damageType: .wind,
        targetType: .singleEnemy
    )

    // MARK: - Aeolus (Wind King)
    static let bagOfWinds = Ability(
        name: "Bag of Winds", description: "Unleash a chaotic storm.", manaCost: 40,
        type: .damage, power: 45, attributeScaling: .willpower, diceRoll: "5d8", damageType: .wind,
        targetType: .allEnemies, cooldown: 3,
        statusEffects: [StatusEffectDefinition(type: .confusion, duration: 2, chance: 0.5)]
    )

    // MARK: - Aeon (Time)
    static let eternalCycle = Ability(
        name: "Eternal Cycle", description: "Age or de-age target.", manaCost: 50,
        type: .utility, power: 0, attributeScaling: .wisdom, diceRoll: "1d100", damageType: .force,
        targetType: .singleEnemy, cooldown: 5,
        statusEffects: [StatusEffectDefinition(type: .slow, duration: 3, chance: 1.0)]
    )

    // MARK: - Aergia (Sloth)
    static let lethargy = Ability(
        name: "Lethargy", description: "Put enemies to sleep or slow them.", manaCost: 25,
        type: .debuff, power: 0, attributeScaling: .willpower, diceRoll: "1d20",
        damageType: .psychic, targetType: .allEnemies,
        statusEffects: [
            StatusEffectDefinition(type: .sleep, duration: 2, chance: 0.3),
            StatusEffectDefinition(type: .slow, duration: 3, chance: 0.7),
        ]
    )

    // MARK: - Aether (Upper Air)
    static let pureLight = Ability(
        name: "Pure Light", description: "Searing divine light.", manaCost: 45,
        type: .damage, power: 50, attributeScaling: .intelligence, diceRoll: "5d10",
        damageType: .radiant, targetType: .allEnemies,
        statusEffects: [StatusEffectDefinition(type: .accuracyDown, duration: 3, magnitude: 4)]
    )

    // MARK: - Aetna (Volcano)
    static let volcanicEruption = Ability(
        name: "Volcanic Eruption", description: "Spew lava and ash.", manaCost: 40,
        type: .damage, power: 40, attributeScaling: .strength, diceRoll: "4d10", damageType: .fire,
        targetType: .allEnemies, cooldown: 4,
        statusEffects: [StatusEffectDefinition(type: .burn, duration: 3, magnitude: 5)]
    )

    // MARK: - Aex (Gorgoneion effect or Pan's Wife) - Using Fear/Shield
    static let shieldBash = Ability(
        name: "Shield Bash", description: "Strike with a shield.", manaCost: 15,
        type: .damage, power: 15, attributeScaling: .strength, diceRoll: "2d6",
        damageType: .physical, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .stun, duration: 1, chance: 0.3)]
    )

    // MARK: - Aganippe (Inspiration)
    static let musesDrink = Ability(
        name: "Muse's Drink", description: "Inspire greatness.", manaCost: 20,
        type: .buff, power: 0, attributeScaling: .intelligence, diceRoll: "1d1", damageType: .water,
        targetType: .singleAlly,
        statusEffects: [StatusEffectDefinition(type: .intelligenceUp, duration: 4, magnitude: 3)]
    )

    // MARK: - Agdistis (Madness)
    static let wildFrenzy = Ability(
        name: "Wild Frenzy", description: "Drive target mad.", manaCost: 30,
        type: .debuff, power: 10, attributeScaling: .willpower, diceRoll: "2d8",
        damageType: .psychic, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .confusion, duration: 3, chance: 0.8)]
    )

    // MARK: - Aglaea (Grace)
    static let splendour = Ability(
        name: "Splendour", description: "Blinding beauty.", manaCost: 20,
        type: .debuff, power: 10, attributeScaling: .wisdom, diceRoll: "1d8", damageType: .radiant,
        targetType: .allEnemies,
        statusEffects: [StatusEffectDefinition(type: .accuracyDown, duration: 2, magnitude: 3)]
    )

    // MARK: - Agon (Contest)
    static let challenge = Ability(
        name: "Challenge", description: "Force a duel or struggle.", manaCost: 15,
        type: .debuff, power: 0, attributeScaling: .strength, diceRoll: "1d20",
        damageType: .psychic, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .defenseDown, duration: 2, magnitude: 2)]
    )

    // MARK: - Agreus & Agros (Rustic)
    static let rusticTrap = Ability(
        name: "Rustic Trap", description: "Ensnare the enemy.", manaCost: 15,
        type: .debuff, power: 10, attributeScaling: .dexterity, diceRoll: "1d6",
        damageType: .nature, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .slow, duration: 2, chance: 1.0)]
    )

    // MARK: - Agrius (Giants)
    static let giantCrush = Ability(
        name: "Giant Crush", description: "Massive crushing blow.", manaCost: 20,
        type: .damage, power: 30, attributeScaling: .strength, diceRoll: "3d8",
        damageType: .physical, targetType: .singleEnemy
    )
    static let manEatingBite = Ability(
        name: "Man-Eating Bite", description: "Savage bite.", manaCost: 20,
        type: .damage, power: 25, attributeScaling: .strength, diceRoll: "2d10",
        damageType: .physical, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .bleed, duration: 3, magnitude: 5)]
    )

    // MARK: - Alala (War Cry)
    static let piercingScream = Ability(
        name: "Piercing Scream", description: "Deafen and terrify.", manaCost: 25,
        type: .damage, power: 20, attributeScaling: .willpower, diceRoll: "2d10",
        damageType: .sonic, targetType: .allEnemies,
        statusEffects: [StatusEffectDefinition(type: .stun, duration: 1, chance: 0.3)]
    )

    // MARK: - Alastor (Avenger)
    static let bloodFeud = Ability(
        name: "Blood Feud", description: "Mark for vengeance.", manaCost: 20,
        type: .debuff, power: 10, attributeScaling: .willpower, diceRoll: "1d8",
        damageType: .necrotic, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .defenseDown, duration: 3, magnitude: 3)]
    )

    // MARK: - Alce (Battle Strength)
    static let battleProwess = Ability(
        name: "Battle Prowess", description: "Enhance combat skills.", manaCost: 20,
        type: .buff, power: 0, attributeScaling: .strength, diceRoll: "1d1", damageType: .physical,
        targetType: .selfTarget,
        statusEffects: [
            StatusEffectDefinition(type: .strengthUp, duration: 3, magnitude: 3),
            StatusEffectDefinition(type: .accuracyUp, duration: 3, magnitude: 2),
        ]
    )

    // MARK: - Alcon (Archer)
    static let snakeShot = Ability(
        name: "Snake Shot", description: "Impossible shot.", manaCost: 15,
        type: .damage, power: 25, attributeScaling: .dexterity, diceRoll: "1d20",
        damageType: .physical, targetType: .singleEnemy
    )

    // MARK: - Alcyone (Pleiad)
    static let halcyonDays = Ability(
        name: "Halcyon Days", description: "Calm the storm.", manaCost: 30,
        type: .heal, power: 20, attributeScaling: .wisdom, diceRoll: "2d10", damageType: .water,
        targetType: .allAllies,
        statusEffects: [StatusEffectDefinition(type: .regeneration, duration: 2, magnitude: 5)]
    )

    // MARK: - Alcyoneus (Giant)
    static let palleneImmortality = Ability(
        name: "Pallene Immortality", description: "Regen in homeland.", manaCost: 20,
        type: .buff, power: 0, attributeScaling: .constitution, diceRoll: "1d1", damageType: .earth,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .regeneration, duration: 5, magnitude: 10)]
    )
    static let rockThrow = Ability(
        name: "Rock Throw", description: "Hurl a massive stone.", manaCost: 15,
        type: .damage, power: 25, attributeScaling: .strength, diceRoll: "2d12", damageType: .earth,
        targetType: .singleEnemy
    )

    // MARK: - Alcyonides (Kingfishers)
    static let seaDive = Ability(
        name: "Sea Dive", description: "Dive to attack.", manaCost: 10,
        type: .damage, power: 15, attributeScaling: .agility, diceRoll: "2d6", damageType: .water,
        targetType: .singleEnemy
    )

    // MARK: - Alecto (Fury)
    static let unceasingAnger = Ability(
        name: "Unceasing Anger", description: "Berserk state.", manaCost: 25,
        type: .buff, power: 0, attributeScaling: .willpower, diceRoll: "1d1", damageType: .fire,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .strengthUp, duration: 4, magnitude: 4)]
    )

    // MARK: - Aletheia (Truth)
    static let revealTruth = Ability(
        name: "Reveal Truth", description: "Dispel illusions.", manaCost: 20,
        type: .utility, power: 0, attributeScaling: .wisdom, diceRoll: "1d20", damageType: .radiant,
        targetType: .allEnemies,
        statusEffects: [StatusEffectDefinition(type: .evasionDown, duration: 3, magnitude: 5)]
    )

    // MARK: - Alexiares & Anicetus
    static let wardOffWar = Ability(
        name: "Ward Off War", description: "Defense against attacks.", manaCost: 20,
        type: .buff, power: 20, attributeScaling: .constitution, diceRoll: "2d8",
        damageType: .physical, targetType: .singleAlly,
        statusEffects: [StatusEffectDefinition(type: .defenseUp, duration: 3, magnitude: 5)]
    )

    // MARK: - Algea (Sorrows)
    static let tearsOfGrief = Ability(
        name: "Tears of Grief", description: "Ovetwhelming sadness.", manaCost: 20,
        type: .debuff, power: 10, attributeScaling: .willpower, diceRoll: "1d8",
        damageType: .psychic, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .willpowerDown, duration: 3, magnitude: 3)]
    )

    // MARK: - Aloadae (Giants)
    static let mountainPile = Ability(
        name: "Mountain Pile", description: "Pile mountains on top of enemy.", manaCost: 35,
        type: .damage, power: 40, attributeScaling: .strength, diceRoll: "4d10", damageType: .earth,
        targetType: .singleEnemy, cooldown: 3,
        statusEffects: [StatusEffectDefinition(type: .stun, duration: 1, chance: 0.4)]
    )

    // MARK: - Alpheus (River)
    static let pursuit = Ability(
        name: "Pursuit", description: "Relentless chase.", manaCost: 15,
        type: .buff, power: 10, attributeScaling: .agility, diceRoll: "1d8", damageType: .physical,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .speedUp, duration: 3, magnitude: 3)]
    )

    // MARK: - Amaltheia (Goat Nurse)
    static let cornucopia = Ability(
        name: "Cornucopia", description: "Horn of plenty.", manaCost: 25,
        type: .heal, power: 25, attributeScaling: .luck, diceRoll: "3d8", damageType: .radiant,
        targetType: .allAllies
    )

    // MARK: - Amechania (Helplessness)
    static let despair = Ability(
        name: "Despair", description: "Remove hope.", manaCost: 20,
        type: .debuff, power: 0, attributeScaling: .willpower, diceRoll: "1d20",
        damageType: .psychic, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .willpowerDown, duration: 3, magnitude: 4)]
    )

    // MARK: - Amnisiades (Artemis Attendants)
    static let swiftness = Ability(
        name: "Swiftness", description: "Increase speed.", manaCost: 15,
        type: .buff, power: 0, attributeScaling: .agility, diceRoll: "1d1", damageType: .wind,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .speedUp, duration: 3, magnitude: 4)]
    )

    // MARK: - Common River Ability
    static let riverSurge = Ability(
        name: "River Surge", description: "Wave of water.", manaCost: 20,
        type: .damage, power: 25, attributeScaling: .constitution, diceRoll: "3d6",
        damageType: .water, targetType: .allEnemies
    )

    // MARK: - Amphiaraus (Oracle)
    static let earthSwallow = Ability(
        name: "Earth Swallow", description: "Escape into the earth.", manaCost: 20,
        type: .utility, power: 0, attributeScaling: .wisdom, diceRoll: "1d1", damageType: .earth,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .defenseUp, duration: 2, magnitude: 10)]
    )

    // MARK: - Amphitrite (Sea Queen)
    static let summonSeaMonsters = Ability(
        name: "Sea Beast Call", description: "Summon a sea creature.", manaCost: 30,
        type: .damage, power: 25, attributeScaling: .wisdom, diceRoll: "3d6", damageType: .water,
        targetType: .singleEnemy
    )
    static let tidalWave = Ability(
        name: "Tidal Wave", description: "Massive wave attack.", manaCost: 40,
        type: .damage, power: 30, attributeScaling: .wisdom, diceRoll: "4d6", damageType: .water,
        targetType: .allEnemies, cooldown: 3
    )

    // MARK: - Ananke (Necessity)
    static let unbreakableChains = Ability(
        name: "Unbreakable Chains", description: "Bind the enemy.", manaCost: 50,
        type: .debuff, power: 0, attributeScaling: .willpower, diceRoll: "1d100",
        damageType: .force, targetType: .singleEnemy, cooldown: 5,
        statusEffects: [StatusEffectDefinition(type: .stun, duration: 2, chance: 1.0)]
    )

    // MARK: - Anaresineus (Sea)
    static let seaStorm = Ability(
        name: "Sea Storm", description: "Violent waters.", manaCost: 25,
        type: .damage, power: 25, attributeScaling: .constitution, diceRoll: "3d6",
        damageType: .water, targetType: .allEnemies
    )

    // MARK: - Anatole (Dawn)
    static let sunrise = Ability(
        name: "Sunrise", description: "New day's light.", manaCost: 20,
        type: .buff, power: 0, attributeScaling: .wisdom, diceRoll: "1d1", damageType: .radiant,
        targetType: .allAllies,
        statusEffects: [StatusEffectDefinition(type: .luckUp, duration: 3, magnitude: 2)]
    )

    // MARK: - Anchiale (Fire Titaness)
    static let kilnFire = Ability(
        name: "Kiln Fire", description: "Intense heat.", manaCost: 25,
        type: .damage, power: 30, attributeScaling: .intelligence, diceRoll: "3d8",
        damageType: .fire, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .burn, duration: 3, magnitude: 4)]
    )

    // MARK: - Anchiroe (Erasinide - Spring Growth)
    static let springGrowth = Ability(
        name: "Spring Growth", description: "Accelerate life.", manaCost: 20,
        type: .heal, power: 15, attributeScaling: .wisdom, diceRoll: "2d6", damageType: .nature,
        targetType: .singleAlly,
        statusEffects: [StatusEffectDefinition(type: .regeneration, duration: 3, magnitude: 3)]
    )

    // MARK: - Androctasiae (Slaughter)
    static let bloodshed = Ability(
        name: "Bloodshed", description: "Revel in carnage.", manaCost: 30,
        type: .damage, power: 35, attributeScaling: .strength, diceRoll: "3d10",
        damageType: .physical, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .bleed, duration: 3, magnitude: 5)]
    )

    // MARK: - Anemoi
    static let northWindBlast = Ability(
        name: "Boreas Blast", description: "Freezing cold wind.", manaCost: 25,
        type: .damage, power: 25, attributeScaling: .strength, diceRoll: "3d8", damageType: .cold,
        targetType: .allEnemies,
        statusEffects: [StatusEffectDefinition(type: .slow, duration: 2, chance: 0.4)]
    )
    static let southWindStorm = Ability(
        name: "Notos Storm", description: "Wet storm wind.", manaCost: 25,
        type: .damage, power: 25, attributeScaling: .constitution, diceRoll: "3d8",
        damageType: .water, targetType: .allEnemies
    )
    static let westWindBreeze = Ability(
        name: "Zephyros Breeze", description: "Gentle spring wind.", manaCost: 20,
        type: .heal, power: 15, attributeScaling: .agility, diceRoll: "2d6", damageType: .wind,
        targetType: .allAllies
    )

    // MARK: - Angleia (Messages)
    static let swiftMessage = Ability(
        name: "Swift Message", description: "Teleport info.", manaCost: 10,
        type: .utility, power: 0, attributeScaling: .agility, diceRoll: "1d1", damageType: .psychic,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .evasionUp, duration: 2, magnitude: 5)]
    )

    // MARK: - Antaeus (Giant)
    static let earthRegen = Ability(
        name: "Earth Regeneration", description: "Heal while touching ground.", manaCost: 0,  // Passive-like
        type: .heal, power: 20, attributeScaling: .constitution, diceRoll: "3d6",
        damageType: .earth, targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .regeneration, duration: 3, magnitude: 5)]
    )
    static let ribCrush = Ability(
        name: "Rib Crush", description: "Bear hug squeeze.", manaCost: 25,
        type: .damage, power: 30, attributeScaling: .strength, diceRoll: "3d8",
        damageType: .physical, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .stun, duration: 1, chance: 0.3)]
    )

    // MARK: - Anteros (Avenged Love)
    static let loveReversal = Ability(
        name: "Love Reversal", description: "Return damage as love/pain.", manaCost: 20,
        type: .damage, power: 20, attributeScaling: .wisdom, diceRoll: "2d8", damageType: .psychic,
        targetType: .singleEnemy
    )

    // MARK: - Apate (Deceit)
    static let falseImage = Ability(
        name: "False Image", description: "Create a decoy.", manaCost: 20,
        type: .utility, power: 0, attributeScaling: .intelligence, diceRoll: "1d1",
        damageType: .psychic, targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .evasionUp, duration: 3, magnitude: 10)]
    )

    // MARK: - Aphrodite
    static let charmPerson = Ability(
        name: "Divine Charm", description: "Control target.", manaCost: 25,
        type: .debuff, power: 0, attributeScaling: .wisdom, diceRoll: "1d20", damageType: .psychic,
        targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .charm, duration: 2, chance: 0.8)]
    )
    static let dovesGrace = Ability(
        name: "Dove's Grace", description: "Evasion boost.", manaCost: 10,
        type: .buff, power: 20, attributeScaling: .agility, diceRoll: "1d1", damageType: .wind,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .evasionUp, duration: 3, magnitude: 5)]
    )

    // MARK: - Apollo
    static let plagueArrow = Ability(
        name: "Plague Arrow", description: "Infectious shot.", manaCost: 30,
        type: .damage, power: 30, attributeScaling: .dexterity, diceRoll: "3d8",
        damageType: .poison, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .poison, duration: 3, magnitude: 5)]
    )
    static let sunChariot = Ability(
        name: "Sun Chariot", description: "Fly across the sky.", manaCost: 30,
        type: .buff, power: 20, attributeScaling: .agility, diceRoll: "2d10", damageType: .fire,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .speedUp, duration: 3, magnitude: 5)]
    )
    static let prophecyArrow = Ability(
        name: "Prophecy Shot", description: "Always hits.", manaCost: 20,
        type: .damage, power: 25, attributeScaling: .wisdom, diceRoll: "1d20", damageType: .radiant,
        targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .accuracyUp, duration: 1, magnitude: 10)]  // Self buff attached? Or just high hit rate representation
    )

    // MARK: - Arachne
    static let webWeave = Ability(
        name: "Web Weave", description: "Entangle enemy.", manaCost: 15,
        type: .debuff, power: 0, attributeScaling: .dexterity, diceRoll: "1d6",
        damageType: .physical, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .slow, duration: 2, chance: 1.0)]
    )
    static let poisonBite = Ability(
        name: "Poison Bite", description: "Venomous fangs.", manaCost: 20,
        type: .damage, power: 20, attributeScaling: .dexterity, diceRoll: "2d8",
        damageType: .poison, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .poison, duration: 3, magnitude: 4)]
    )

    // MARK: - Ares
    static let godOfWar = Ability(
        name: "God of War", description: "Ultimate battle trance.", manaCost: 50,
        type: .buff, power: 0, attributeScaling: .strength, diceRoll: "1d1", damageType: .physical,
        targetType: .selfTarget,
        statusEffects: [
            StatusEffectDefinition(type: .strengthUp, duration: 5, magnitude: 5),
            StatusEffectDefinition(type: .enduranceUp, duration: 5, magnitude: 5),
        ]
    )

    // MARK: - Argus Panoptes
    static let hundredEyesWatch = Ability(
        name: "Hundred Eyes", description: "Nothing escapes sight.", manaCost: 0,
        type: .buff, power: 0, attributeScaling: .perception, diceRoll: "1d1", damageType: .psychic,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .accuracyUp, duration: 5, magnitude: 10)]
    )
    static let giantSmash = Ability(
        name: "Giant Smash", description: "Simple powerful smash.", manaCost: 15,
        type: .damage, power: 25, attributeScaling: .strength, diceRoll: "2d12",
        damageType: .physical, targetType: .singleEnemy
    )

    // MARK: - Ariadne
    static let goldenThread = Ability(
        name: "Golden Thread", description: "Find the path.", manaCost: 15,
        type: .utility, power: 0, attributeScaling: .intelligence, diceRoll: "1d1",
        damageType: .radiant, targetType: .party,
        statusEffects: [StatusEffectDefinition(type: .accuracyUp, duration: 3, magnitude: 3)]
    )

    // MARK: - Arimaspians
    static let spearThrust = Ability(
        name: "Spear Thrust", description: "Stab with spear.", manaCost: 10,
        type: .damage, power: 15, attributeScaling: .strength, diceRoll: "1d10",
        damageType: .physical, targetType: .singleEnemy
    )

    // MARK: - Arion (Horse)
    static let horseKick = Ability(
        name: "Horse Kick", description: "Powerful kick.", manaCost: 15,
        type: .damage, power: 20, attributeScaling: .strength, diceRoll: "2d8",
        damageType: .physical, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .stun, duration: 1, chance: 0.3)]
    )
    static let immortalStamina = Ability(
        name: "Immortal Stamina", description: "Never tires.", manaCost: 30,
        type: .heal, power: 50, attributeScaling: .constitution, diceRoll: "5d10",
        damageType: .radiant, targetType: .selfTarget
    )

    // MARK: - Aristaeus
    static let beeSwarm = Ability(
        name: "Bee Swarm", description: "Summon bees to invalid.", manaCost: 20,
        type: .damage, power: 15, attributeScaling: .wisdom, diceRoll: "4d4", damageType: .nature,
        targetType: .allEnemies,
        statusEffects: [StatusEffectDefinition(type: .poison, duration: 2, magnitude: 2)]
    )
    static let dungBeetleForm = Ability(
        name: "Beetle Form", description: "Hardened shell.", manaCost: 15,
        type: .buff, power: 20, attributeScaling: .constitution, diceRoll: "2d6",
        damageType: .earth, targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .defenseUp, duration: 3, magnitude: 5)]
    )

    // MARK: - Artemis
    static let moonArrow = Ability(
        name: "Moon Arrow", description: "Glowing silver arrow.", manaCost: 25,
        type: .damage, power: 30, attributeScaling: .dexterity, diceRoll: "3d8",
        damageType: .radiant, targetType: .singleEnemy
    )
    static let wildShape = Ability(
        name: "Wild Shape", description: "Transform into beast.", manaCost: 30,
        type: .buff, power: 0, attributeScaling: .wisdom, diceRoll: "1d1", damageType: .nature,
        targetType: .selfTarget,
        statusEffects: [
            StatusEffectDefinition(type: .strengthUp, duration: 4, magnitude: 4),
            StatusEffectDefinition(type: .speedUp, duration: 4, magnitude: 4),
        ]
    )
    static let aimedShot = Ability(
        name: "Aimed Shot", description: "Prepare for critical hit.", manaCost: 15,
        type: .buff, power: 0, attributeScaling: .dexterity, diceRoll: "1d1", damageType: .physical,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .accuracyUp, duration: 1, magnitude: 10)]
    )

    // MARK: - Asbeton (Kiln Spirit)
    // Uses kilnFire (defined above)

    // MARK: - Ascalaphus (Orchard)
    static let owlShriek = Ability(
        name: "Owl Shriek", description: "Terrifying sound.", manaCost: 15,
        type: .debuff, power: 10, attributeScaling: .willpower, diceRoll: "1d8", damageType: .sonic,
        targetType: .allEnemies,
        statusEffects: [StatusEffectDefinition(type: .fear, duration: 1, chance: 0.5)]
    )
    static let pomegranateCurse = Ability(
        name: "Pomegranate Curse", description: "Bind to underworld.", manaCost: 25,
        type: .debuff, power: 0, attributeScaling: .wisdom, diceRoll: "1d20", damageType: .necrotic,
        targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .slow, duration: 3, chance: 1.0)]
    )

    // MARK: - Ascanius (River)
    static let mysianCurrent = Ability(
        name: "Mysian Current", description: "Swift flowing water.", manaCost: 20,
        type: .buff, power: 10, attributeScaling: .agility, diceRoll: "1d6", damageType: .water,
        targetType: .allAllies,
        statusEffects: [StatusEffectDefinition(type: .speedUp, duration: 2, magnitude: 3)]
    )

    // MARK: - Asclepius
    static let panacea = Ability(
        name: "Panacea", description: "Cure all ills.", manaCost: 50,
        type: .heal, power: 100, attributeScaling: .wisdom, diceRoll: "10d10", damageType: .radiant,
        targetType: .allAllies, cooldown: 5,
        statusEffects: [StatusEffectDefinition(type: .regeneration, duration: 3, magnitude: 10)]
    )
    static let serpentStaff = Ability(
        name: "Serpent Staff", description: "Strike and heal.", manaCost: 15,
        type: .damage, power: 20, attributeScaling: .strength, diceRoll: "2d8",
        damageType: .physical, targetType: .singleEnemy
    )

    // MARK: - Ascra (Poetry)
    static let poeticInspiration = Ability(
        name: "Poetic Inspiration", description: "Inspire courage.", manaCost: 20,
        type: .buff, power: 0, attributeScaling: .willpower, diceRoll: "1d1", damageType: .psychic,
        targetType: .allAllies,
        statusEffects: [StatusEffectDefinition(type: .willpowerUp, duration: 3, magnitude: 3)]
    )

    // MARK: - Asia (Oceanid)
    static let forethoughtGift = Ability(
        name: "Forethought", description: "Predict attacks.", manaCost: 25,
        type: .buff, power: 0, attributeScaling: .wisdom, diceRoll: "1d1", damageType: .psychic,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .evasionUp, duration: 3, magnitude: 5)]
    )

    // MARK: - Asopus (River)
    static let boeotianFlood = Ability(
        name: "Boeotian Flood", description: "Flood the land.", manaCost: 35,
        type: .damage, power: 30, attributeScaling: .constitution, diceRoll: "4d8",
        damageType: .water, targetType: .allEnemies
    )

    // MARK: - Asteria (Star)
    static let starFall = Ability(
        name: "Star Fall", description: "Call down falling stars.", manaCost: 30,
        type: .damage, power: 30, attributeScaling: .intelligence, diceRoll: "3d10",
        damageType: .radiant, targetType: .allEnemies
    )
    static let quailFlight = Ability(
        name: "Quail Flight", description: "Escape as a bird.", manaCost: 15,
        type: .utility, power: 0, attributeScaling: .agility, diceRoll: "1d1", damageType: .wind,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .evasionUp, duration: 2, magnitude: 5)]
    )

    // MARK: - Asterion (River)
    static let argiveFlow = Ability(
        name: "Argive Flow", description: "Life-giving water.", manaCost: 20,
        type: .heal, power: 20, attributeScaling: .wisdom, diceRoll: "3d6", damageType: .water,
        targetType: .singleAlly
    )

    // MARK: - Asterodeia (Nymph)
    static let caucasianFrost = Ability(
        name: "Caucasian Frost", description: "Mountain chill.", manaCost: 20,
        type: .damage, power: 20, attributeScaling: .intelligence, diceRoll: "2d8",
        damageType: .cold, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .slow, duration: 2, chance: 0.5)]
    )

    // MARK: - Asterope (Star Nymph)
    static let starNymphLight = Ability(
        name: "Star Nymph Light", description: "Guidance of stars.", manaCost: 15,
        type: .buff, power: 0, attributeScaling: .wisdom, diceRoll: "1d1", damageType: .radiant,
        targetType: .singleAlly,
        statusEffects: [StatusEffectDefinition(type: .accuracyUp, duration: 3, magnitude: 3)]
    )

    // MARK: - Astra Planeta
    static let planetaryOrbit = Ability(
        name: "Planetary Orbit", description: "Defensive satellites.", manaCost: 30,
        type: .buff, power: 0, attributeScaling: .intelligence, diceRoll: "1d1", damageType: .force,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .defenseUp, duration: 4, magnitude: 4)]
    )

    // MARK: - Astraea (Justice)
    static let justiceStrike = Ability(
        name: "Strike of Justice", description: "Punish the wicked.", manaCost: 30,
        type: .damage, power: 35, attributeScaling: .wisdom, diceRoll: "3d10", damageType: .radiant,
        targetType: .singleEnemy
    )

    // MARK: - Astraeus (Titan)
    static let windGust = Ability(
        name: "Wind Gust", description: "Blow enemies back.", manaCost: 20,
        type: .damage, power: 20, attributeScaling: .strength, diceRoll: "3d6", damageType: .wind,
        targetType: .allEnemies
    )

    // MARK: - Astrape (Lightning)
    static let lightningBolt = Ability(
        name: "Lightning Bolt", description: "Bolt from the blue.", manaCost: 30,
        type: .damage, power: 35, attributeScaling: .intelligence, diceRoll: "4d8",
        damageType: .lightning, targetType: .singleEnemy
    )

    // MARK: - Astrothesiai (Constellations)
    static let constellationForm = Ability(
        name: "Constellation Form", description: "Become starlight.", manaCost: 30,
        type: .buff, power: 0, attributeScaling: .wisdom, diceRoll: "1d1", damageType: .radiant,
        targetType: .selfTarget,
        statusEffects: [
            StatusEffectDefinition(type: .defenseUp, duration: 3, magnitude: 5),
            StatusEffectDefinition(type: .evasionUp, duration: 3, magnitude: 5),
        ]
    )

    // MARK: - Asyoche (Nymph)
    // Uses heal

    // MARK: - Ate (Ruin)
    static let blindFolly = Ability(
        name: "Blind Folly", description: "Blind user/enemy.", manaCost: 20,
        type: .debuff, power: 0, attributeScaling: .willpower, diceRoll: "1d20",
        damageType: .psychic, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .accuracyDown, duration: 3, magnitude: 10)]
    )
    static let ruinousDelusion = Ability(
        name: "Ruinous Delusion", description: "Self-destructive thoughts.", manaCost: 25,
        type: .damage, power: 20, attributeScaling: .intelligence, diceRoll: "2d10",
        damageType: .psychic, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .confusion, duration: 2, chance: 0.6)]
    )

    // MARK: - Athena
    static let strategy = Ability(
        name: "Strategy", description: "Tactical advantage.", manaCost: 30,
        type: .buff, power: 0, attributeScaling: .intelligence, diceRoll: "1d1",
        damageType: .psychic, targetType: .allAllies,
        statusEffects: [
            StatusEffectDefinition(type: .accuracyUp, duration: 3, magnitude: 3),
            StatusEffectDefinition(type: .defenseUp, duration: 3, magnitude: 3),
        ]
    )
    static let aegisDeflect = Ability(
        name: "Aegis Deflect", description: "Reflect damage.", manaCost: 35,
        type: .buff, power: 50, attributeScaling: .wisdom, diceRoll: "5d10", damageType: .radiant,
        targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .defenseUp, duration: 2, magnitude: 10)]
    )

    // MARK: - Atlanteia (Hamadryad)
    static let treeBarkSkin = Ability(
        name: "Bark Skin", description: "Harden skin like wood.", manaCost: 15,
        type: .buff, power: 15, attributeScaling: .constitution, diceRoll: "2d6",
        damageType: .nature, targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .defenseUp, duration: 3, magnitude: 3)]
    )

    // MARK: - Atlantis
    static let sunkenWrath = Ability(
        name: "Sunken Wrath", description: "Power of a lost civilization.", manaCost: 50,
        type: .damage, power: 60, attributeScaling: .strength, diceRoll: "6d10", damageType: .water,
        targetType: .allEnemies, cooldown: 5
    )

    // MARK: - Atlas
    static let skyBurden = Ability(
        name: "Burden of the Sky", description: "Crush enemy with weight.", manaCost: 40,
        type: .damage, power: 50, attributeScaling: .strength, diceRoll: "5d10",
        damageType: .physical, targetType: .singleEnemy,
        statusEffects: [StatusEffectDefinition(type: .slow, duration: 3, chance: 1.0)]
    )

    // MARK: - Atropus (Fate)
    static let fateCut = Ability(
        name: "Cut the Thread", description: "End life.", manaCost: 100,
        type: .damage, power: 100, attributeScaling: .willpower, diceRoll: "1d100",
        damageType: .necrotic, targetType: .singleEnemy, cooldown: 10,
        statusEffects: [StatusEffectDefinition(type: .stun, duration: 1, chance: 0.5)]
    )

    // MARK: - Attis (Consort)
    static let frenziedDance = Ability(
        name: "Frenzied Dance", description: "Wild ecstatic dance.", manaCost: 20,
        type: .buff, power: 0, attributeScaling: .agility, diceRoll: "1d1", damageType: .nature,
        targetType: .selfTarget,
        statusEffects: [
            StatusEffectDefinition(type: .speedUp, duration: 3, magnitude: 5),
            StatusEffectDefinition(type: .defenseDown, duration: 3, magnitude: 2),
        ]
    )

    // MARK: - Auge (First Light)
    static let dawnLight = Ability(
        name: "Dawn Light", description: "Dispel darkness.", manaCost: 20,
        type: .utility, power: 0, attributeScaling: .wisdom, diceRoll: "1d1", damageType: .radiant,
        targetType: .allEnemies,
        statusEffects: [StatusEffectDefinition(type: .accuracyDown, duration: 1, magnitude: 3)]
    )

    // MARK: - Auloniades (Glen Nymphs)
    static let glenWhisper = Ability(
        name: "Glen Whisper", description: "Secret paths.", manaCost: 15,
        type: .utility, power: 0, attributeScaling: .wisdom, diceRoll: "1d1", damageType: .nature,
        targetType: .party,
        statusEffects: [StatusEffectDefinition(type: .evasionUp, duration: 2, magnitude: 3)]
    )

    // MARK: - Aura & Aurae (Breeze)
    // Uses windGust

    // MARK: - Automatones (Statues)
    static let automatonCrush = Ability(
        name: "Automaton Crush", description: "Relentless robotic crush.", manaCost: 20,
        type: .damage, power: 30, attributeScaling: .strength, diceRoll: "3d8",
        damageType: .physical, targetType: .singleEnemy
    )
    static let metalBody = Ability(
        name: "Metal Body", description: "Impervious skin.", manaCost: 0,
        type: .buff, power: 10, attributeScaling: .constitution, diceRoll: "1d1",
        damageType: .physical, targetType: .selfTarget,
        statusEffects: [StatusEffectDefinition(type: .defenseUp, duration: 99, magnitude: 5)]  // Permanent-ish
    )

    // MARK: - Auxesia (Growth)
    static let growthSurge = Ability(
        name: "Growth Surge", description: "Enlarge or strengthen.", manaCost: 25,
        type: .buff, power: 20, attributeScaling: .wisdom, diceRoll: "2d10", damageType: .nature,
        targetType: .singleAlly,
        statusEffects: [StatusEffectDefinition(type: .strengthUp, duration: 3, magnitude: 4)]
    )

    // MARK: - Axius (River)
    static let paeonianSurge = Ability(
        name: "Paeonian Surge", description: "Wide river surge.", manaCost: 25,
        type: .damage, power: 25, attributeScaling: .constitution, diceRoll: "3d8",
        damageType: .water, targetType: .allEnemies,
        statusEffects: [StatusEffectDefinition(type: .slow, duration: 1, chance: 0.5)]
    )

    // MARK: - General Utilities
    static let heal = Ability(
        name: "Heal", description: "Restore health.", manaCost: 15,
        type: .heal, power: 20, attributeScaling: .wisdom, diceRoll: "2d8", damageType: .radiant,
        targetType: .singleAlly
    )
    static let prophecy = Ability(
        name: "Prophecy", description: "Foretell the future.", manaCost: 35,
        type: .utility, power: 0, attributeScaling: .wisdom, diceRoll: "1d20", damageType: .radiant,
        targetType: .party,
        statusEffects: [StatusEffectDefinition(type: .accuracyUp, duration: 3, magnitude: 5)]
    )
}
