import Foundation

extension Ability {
    // MARK: - Achelous (River God)
    static let hornStrike = Ability(
        name: "Horn Strike", description: "Strike with a river-bull horn.", manaCost: 15,
        type: .damage, power: 25, attributeScaling: .strength, diceRoll: "2d10",
        damageType: .physical
    )
    static let riverWrestling = Ability(
        name: "River Wrestling", description: "Grapple and drown the enemy.", manaCost: 20,
        type: .damage, power: 30, attributeScaling: .strength, diceRoll: "3d8", damageType: .water  // Water/Cold
    )

    // MARK: - Aba (Nymph)
    static let thracianCharm = Ability(
        name: "Thracian Charm", description: "Allure of a Thracian nymph.", manaCost: 10,
        type: .debuff, power: 0, attributeScaling: .luck, diceRoll: "1d6", damageType: .psychic
    )

    // MARK: - Abarbaree (Naiad)
    static let bucolicGrace = Ability(
        name: "Bucolic Grace", description: "Grace of the shepherd lands.", manaCost: 10,
        type: .heal, power: 15, attributeScaling: .wisdom, diceRoll: "2d6", damageType: .radiant
    )

    // MARK: - Aceso (Healing Goddess)
    static let curingTouch = Ability(
        name: "Curing Touch", description: "Process of curing illness.", manaCost: 20,
        type: .heal, power: 25, attributeScaling: .wisdom, diceRoll: "3d6", damageType: .radiant
    )

    // MARK: - Acheloides (Naiads)
    static let sirenSong = Ability(  // Sometimes associated with Sirens
        name: "Siren Song", description: "Lure enemies into danger.", manaCost: 20,
        type: .debuff, power: 10, attributeScaling: .luck, diceRoll: "1d8", damageType: .psychic
    )

    // MARK: - Acheron (River of Pain)
    static let riverOfPain = Ability(
        name: "River of Pain", description: "Inflict spiritual agony.", manaCost: 30,
        type: .damage, power: 35, attributeScaling: .willpower, diceRoll: "4d8",
        damageType: .necrotic
    )

    // MARK: - Achlys (Death Mist)
    static let deathMist = Ability(
        name: "Death Mist", description: "Cloud eyes with the mist of death.", manaCost: 40,
        type: .debuff, power: 50, attributeScaling: .willpower, diceRoll: "1d100",
        damageType: .necrotic
    )

    // MARK: - Acis (River Spirit)
    static let sicilianSpring = Ability(
        name: "Sicilian Spring", description: "Transform into water to evade.", manaCost: 15,
        type: .buff, power: 10, attributeScaling: .agility, diceRoll: "1d6", damageType: .water
    )

    // MARK: - Acmon (Dactyl / Cercopes)
    static let anvilStrike = Ability(
        name: "Anvil Strike", description: "Strike as hard as an anvil.", manaCost: 15,
        type: .damage, power: 20, attributeScaling: .strength, diceRoll: "2d8",
        damageType: .physical
    )
    static let monkeyTrick = Ability(
        name: "Monkey Trick", description: "Confuse and steal.", manaCost: 10,
        type: .utility, power: 5, attributeScaling: .luck, diceRoll: "1d4", damageType: .psychic
    )

    // MARK: - Acraea (Nurse of Hera)
    static let nursesCare = Ability(
        name: "Nurse's Care", description: "Protective ward.", manaCost: 15,
        type: .buff, power: 15, attributeScaling: .wisdom, diceRoll: "2d6", damageType: .radiant
    )

    // MARK: - Acratus (Unmixed Wine)
    static let intoxication = Ability(
        name: "Intoxication", description: "Confuse with potent wine.", manaCost: 15,
        type: .debuff, power: 10, attributeScaling: .constitution, diceRoll: "1d8",
        damageType: .poison
    )

    // MARK: - Acte (Agte - Hora)
    static let afternoonSun = Ability(
        name: "Afternoon Sun", description: "Blinding light of the afternoon.", manaCost: 15,
        type: .damage, power: 20, attributeScaling: .intelligence, diceRoll: "2d8",
        damageType: .fire
    )

    // MARK: - Adephagia (Gluttony)
    static let ravenousHunger = Ability(
        name: "Ravenous Hunger", description: "Drain enemy stamina.", manaCost: 20,
        type: .damage, power: 15, attributeScaling: .constitution, diceRoll: "2d8",
        damageType: .necrotic
    )

    // MARK: - Adicia (Injustice)
    static let unfairBlow = Ability(
        name: "Unfair Blow", description: "Strike when opponent is down.", manaCost: 10,
        type: .damage, power: 25, attributeScaling: .dexterity, diceRoll: "3d6",
        damageType: .physical
    )

    // MARK: - Adrasteia (Nemesis / Nymph)
    static let inevitableRetribution = Ability(
        name: "Inevitability", description: "Damage that cannot be dodged.", manaCost: 25,
        type: .damage, power: 30, attributeScaling: .wisdom, diceRoll: "3d8", damageType: .force
    )

    // MARK: - Aea (Nymph)
    static let colchisMagic = Ability(
        name: "Colchis Magic", description: "Minor sorcery.", manaCost: 15,
        type: .damage, power: 18, attributeScaling: .intelligence, diceRoll: "2d8",
        damageType: .fire
    )

    // MARK: - Aeacus (Judge)
    static let antMyrmidons = Ability(
        name: "Ant Myrmidons", description: "Summon ants to attack.", manaCost: 20,
        type: .damage, power: 20, attributeScaling: .wisdom, diceRoll: "4d4", damageType: .physical
    )
    static let underworldJudgment = Ability(
        name: "Judgment", description: "Weigh the soul.", manaCost: 30,
        type: .debuff, power: 40, attributeScaling: .wisdom, diceRoll: "1d20", damageType: .psychic
    )

    // MARK: - Aedos (Modesty)
    static let humbleAura = Ability(
        name: "Humble Aura", description: "Pacify aggression.", manaCost: 20,
        type: .debuff, power: 10, attributeScaling: .willpower, diceRoll: "1d6",
        damageType: .psychic
    )

    // MARK: - Aegaeon (Briareus) & Aegaeus
    static let hundredHandSlap = Ability(
        name: "Hundred Hand Slap", description: "A barrage of blows.", manaCost: 40,
        type: .damage, power: 50, attributeScaling: .strength, diceRoll: "10d4",
        damageType: .physical
    )
    static let seaStorm = Ability(
        name: "Sea Storm", description: "Violent ocean waves.", manaCost: 25,
        type: .aoe, power: 30, attributeScaling: .strength, diceRoll: "3d10", damageType: .water
    )

    // MARK: - Aegeirus (Poplar)
    static let poplarRustle = Ability(
        name: "Poplar Rustle", description: "Soothing sound.", manaCost: 10,
        type: .heal, power: 10, attributeScaling: .wisdom, diceRoll: "1d8", damageType: .psychic
    )

    // MARK: - Aegina (Nymph)
    static let islandFortress = Ability(
        name: "Island Fortress", description: "Defensive stance.", manaCost: 15,
        type: .buff, power: 20, attributeScaling: .endurance, diceRoll: "2d6", damageType: .physical
    )

    // MARK: - Aegipan (Goat-Fish)
    static let panicCry = Ability(
        name: "Panic Cry", description: "Induce fear.", manaCost: 15,
        type: .debuff, power: 0, attributeScaling: .willpower, diceRoll: "1d6", damageType: .psychic
    )

    // MARK: - Aegle (1 & 2 - Health/Light)
    static let radiantHealth = Ability(
        name: "Radiant Health", description: "Glowing vitality.", manaCost: 20,
        type: .heal, power: 30, attributeScaling: .constitution, diceRoll: "3d8",
        damageType: .radiant
    )

    // MARK: - Aello (Harpy)
    static let stormSnatch = Ability(
        name: "Storm Snatch", description: "Swoop and steal or damage.", manaCost: 15,
        type: .damage, power: 18, attributeScaling: .agility, diceRoll: "2d8", damageType: .wind
    )

    // MARK: - Aeolus (Wind God)
    static let bagOfWinds = Ability(
        name: "Bag of Winds", description: "Release chaotic winds.", manaCost: 35,
        type: .aoe, power: 40, attributeScaling: .intelligence, diceRoll: "4d10", damageType: .wind
    )

    // MARK: - Aeon (Time)
    static let eternalCycle = Ability(
        name: "Eternal Cycle", description: "Renew self.", manaCost: 50,
        type: .heal, power: 100, attributeScaling: .willpower, diceRoll: "1d10",
        damageType: .radiant
    )

    // MARK: - Aergia (Sloth)
    static let lethargy = Ability(
        name: "Lethargy", description: "Slow enemy down.", manaCost: 15,
        type: .debuff, power: 10, attributeScaling: .willpower, diceRoll: "1d4",
        damageType: .psychic
    )

    // MARK: - Aether (Upper Air)
    static let pureLight = Ability(
        name: "Pure Light", description: "Sear with heavenly light.", manaCost: 30,
        type: .damage, power: 35, attributeScaling: .intelligence, diceRoll: "3d10",
        damageType: .radiant
    )

    // MARK: - Aetna (Volcano)
    static let volcanicEruption = Ability(
        name: "Eruption", description: "Magma burst.", manaCost: 30,
        type: .aoe, power: 40, attributeScaling: .constitution, diceRoll: "4d8", damageType: .fire
    )

    // MARK: - Aganippe (Inspiration Spring)
    static let musesDrink = Ability(
        name: "Muse's Drink", description: "Grant inspiration/mana.", manaCost: 15,
        type: .utility, power: 20, attributeScaling: .wisdom, diceRoll: "2d8", damageType: .water
    )

    // MARK: - Agdistis (Hermaphrodite/Cybele)
    static let wildFrenzy = Ability(
        name: "Wild Frenzy", description: "Madness of the wilds.", manaCost: 25,
        type: .buff, power: 20, attributeScaling: .strength, diceRoll: "2d10", damageType: .psychic
    )

    // MARK: - Aglaea (Grace)
    static let splendour = Ability(
        name: "Splendour", description: "Blinding beauty.", manaCost: 20,
        type: .debuff, power: 10, attributeScaling: .wisdom, diceRoll: "1d8", damageType: .radiant
    )

    // MARK: - Agon (Contest)
    static let challenge = Ability(
        name: "Challenge", description: "Force a duel.", manaCost: 10,
        type: .debuff, power: 0, attributeScaling: .strength, diceRoll: "1d1", damageType: .psychic
    )

    // MARK: - Agreus & Agros (Rustic)
    static let rusticTrap = Ability(
        name: "Rustic Trap", description: "Ensnare prey.", manaCost: 10,
        type: .debuff, power: 10, attributeScaling: .dexterity, diceRoll: "1d6",
        damageType: .physical
    )

    // MARK: - Agrius (Giants)
    static let manEatingBite = Ability(
        name: "Flesh Bite", description: "Tear flesh.", manaCost: 15,
        type: .damage, power: 20, attributeScaling: .strength, diceRoll: "2d8",
        damageType: .physical
    )

    // MARK: - Alala (War Cry)
    static let piercingScream = Ability(
        name: "Piercing Scream", description: "Deafen and damage.", manaCost: 15,
        type: .damage, power: 15, attributeScaling: .constitution, diceRoll: "2d6",
        damageType: .sonic  // Thunder
    )

    // MARK: - Alastor (Avenger)
    static let bloodFeud = Ability(
        name: "Blood Feud", description: "Mark for vengeance.", manaCost: 20,
        type: .debuff, power: 15, attributeScaling: .willpower, diceRoll: "1d8",
        damageType: .necrotic
    )

    // MARK: - Alce (Prowess)
    static let battleProwess = Ability(
        name: "Battle Prowess", description: "Boost strength.", manaCost: 15,
        type: .buff, power: 10, attributeScaling: .strength, diceRoll: "1d8", damageType: .physical
    )

    // MARK: - Alcon (Archer)
    static let snakeShot = Ability(
        name: "Snake Shot", description: "Impossible archery shot.", manaCost: 15,
        type: .damage, power: 25, attributeScaling: .dexterity, diceRoll: "1d20+5",
        damageType: .physical
    )

    // MARK: - Alcyone & Alcyonides
    static let halcyonDays = Ability(
        name: "Halcyon Days", description: "Calm the storms.", manaCost: 20,
        type: .buff, power: 0, attributeScaling: .wisdom, diceRoll: "1d1", damageType: .water
    )
    static let seaDive = Ability(
        name: "Sea Dive", description: "Dive like a kingfisher.", manaCost: 10,
        type: .damage, power: 15, attributeScaling: .agility, diceRoll: "2d6", damageType: .physical
    )

    // MARK: - Alcyoneus (Giant)
    static let palleneImmortality = Ability(
        name: "Native Strength", description: "Invincible on home soil.", manaCost: 30,
        type: .buff, power: 50, attributeScaling: .constitution, diceRoll: "4d10",
        damageType: .physical
    )
    static let rockThrow = Ability(
        name: "Rock Throw", description: "Hurl a boulder.", manaCost: 15,
        type: .damage, power: 30, attributeScaling: .strength, diceRoll: "3d8",
        damageType: .physical
    )

    // MARK: - Alecto (Fury)
    static let unceasingAnger = Ability(
        name: "Unceasing Anger", description: "Drive target mad.", manaCost: 25,
        type: .debuff, power: 20, attributeScaling: .willpower, diceRoll: "2d8",
        damageType: .psychic
    )

    // MARK: - Aletheia (Truth)
    static let revealTruth = Ability(
        name: "Reveal Truth", description: "Dispel illusions.", manaCost: 15,
        type: .utility, power: 0, attributeScaling: .wisdom, diceRoll: "1d1", damageType: .radiant
    )

    // MARK: - Alexiares & Anicetus
    static let wardOffWar = Ability(
        name: "Ward Off War", description: "Defense against attacks.", manaCost: 20,
        type: .buff, power: 20, attributeScaling: .constitution, diceRoll: "2d8",
        damageType: .physical
    )

    // MARK: - Algea (Sorrows)
    static let tearsOfGrief = Ability(
        name: "Tears of Grief", description: "Weaken spirit.", manaCost: 15,
        type: .debuff, power: 10, attributeScaling: .willpower, diceRoll: "1d6",
        damageType: .necrotic
    )

    // MARK: - Aloadae (Giants)
    static let mountainPile = Ability(
        name: "Mountain Pile", description: "Crush with rocks.", manaCost: 30,
        type: .damage, power: 40, attributeScaling: .strength, diceRoll: "3d12",
        damageType: .physical
    )

    // MARK: - Alpheus (River)
    static let pursuit = Ability(
        name: "Pursuit", description: "Relentless chase.", manaCost: 15,
        type: .buff, power: 10, attributeScaling: .agility, diceRoll: "1d8", damageType: .physical
    )

    // MARK: - Amaltheia (Goat Nurse)
    static let cornucopia = Ability(
        name: "Cornucopia", description: "Restore all resources.", manaCost: 40,
        type: .heal, power: 50, attributeScaling: .wisdom, diceRoll: "5d8", damageType: .radiant
    )

    // MARK: - Amechania (Helplessness)
    static let despair = Ability(
        name: "Despair", description: "Remove action points.", manaCost: 20,
        type: .debuff, power: 0, attributeScaling: .willpower, diceRoll: "1d4", damageType: .psychic
    )

    // MARK: - Amphiaraus (Oracle)
    static let earthSwallow = Ability(
        name: "Earth Swallow", description: "Escape into the earth.", manaCost: 20,
        type: .utility, power: 0, attributeScaling: .wisdom, diceRoll: "1d1", damageType: .earth
    )

    // MARK: - Amphitrite (Sea Queen)
    static let summonSeaMonsters = Ability(
        name: "Sea Beast Call", description: "Summon a sea creature.", manaCost: 30,
        type: .damage, power: 25, attributeScaling: .wisdom, diceRoll: "3d6", damageType: .water
    )
    static let tidalWave = Ability(
        name: "Tidal Wave", description: "Massive wave attack.", manaCost: 40,
        type: .aoe, power: 45, attributeScaling: .intelligence, diceRoll: "5d6", damageType: .water
    )

    // MARK: - Ananke (Necessity)
    static let unbreakableChains = Ability(
        name: "Chains of Fate", description: "Bind eternally.", manaCost: 50,
        type: .debuff, power: 100, attributeScaling: .willpower, diceRoll: "1d1", damageType: .force
    )

    // MARK: - Anatole (Dawn)
    static let sunrise = Ability(
        name: "Sunrise", description: "New beginning.", manaCost: 20,
        type: .buff, power: 15, attributeScaling: .wisdom, diceRoll: "2d6", damageType: .radiant
    )

    // MARK: - Anemoi (Winds)
    static let northWindBlast = Ability(
        name: "Boreas Blast", description: "Freezing wind.", manaCost: 20,
        type: .damage, power: 25, attributeScaling: .intelligence, diceRoll: "3d6",
        damageType: .cold
    )
    static let southWindStorm = Ability(
        name: "Notos Storm", description: "Wet humid storm.", manaCost: 20,
        type: .damage, power: 20, attributeScaling: .intelligence, diceRoll: "3d6",
        damageType: .water
    )
    static let westWindBreeze = Ability(
        name: "Zephyrus Breeze", description: "Gentle healing wind.", manaCost: 15,
        type: .heal, power: 15, attributeScaling: .wisdom, diceRoll: "2d6", damageType: .radiant  // Air
    )

    // MARK: - Angleia (Messages)
    static let swiftMessage = Ability(
        name: "Swift Message", description: "Teleport info.", manaCost: 10,
        type: .utility, power: 0, attributeScaling: .agility, diceRoll: "1d1", damageType: .psychic
    )

    // MARK: - Antaeus (Giant)
    static let earthRegen = Ability(
        name: "Earth Regen", description: "Heal while touching ground.", manaCost: 0,
        type: .heal, power: 30, attributeScaling: .constitution, diceRoll: "3d8", damageType: .earth
    )
    static let ribCrush = Ability(
        name: "Rib Crush", description: "Bear hug.", manaCost: 20,
        type: .damage, power: 35, attributeScaling: .strength, diceRoll: "4d6",
        damageType: .physical
    )

    // MARK: - Anteros (Avenged Love)
    static let loveReversal = Ability(
        name: "Love Reversal", description: "Return damage as love/pain.", manaCost: 20,
        type: .damage, power: 20, attributeScaling: .wisdom, diceRoll: "2d8", damageType: .psychic
    )

    // MARK: - Apate (Deceit)
    static let falseImage = Ability(
        name: "False Image", description: "Create a decoy.", manaCost: 15,
        type: .utility, power: 0, attributeScaling: .intelligence, diceRoll: "1d1",
        damageType: .psychic
    )

    // MARK: - Aphrodite
    static let charmPerson = Ability(
        name: "Divine Charm", description: "Control target.", manaCost: 25,
        type: .debuff, power: 0, attributeScaling: .wisdom, diceRoll: "1d20", damageType: .psychic
    )
    static let dovesGrace = Ability(
        name: "Dove's Grace", description: "Evasion boost.", manaCost: 10,
        type: .buff, power: 15, attributeScaling: .agility, diceRoll: "1d8", damageType: .radiant
    )

    // MARK: - Apollo
    static let plagueArrow = Ability(
        name: "Plague Arrow", description: "Inflict disease.", manaCost: 25,
        type: .damage, power: 30, attributeScaling: .dexterity, diceRoll: "1d20+5",
        damageType: .poison
    )
    static let sunChariot = Ability(
        name: "Sun Chariot", description: "Fly across the sky.", manaCost: 30,
        type: .buff, power: 20, attributeScaling: .agility, diceRoll: "2d10", damageType: .fire
    )
    static let prophecyArrow = Ability(
        name: "Prophecy Shot", description: "Always hits.", manaCost: 20,
        type: .damage, power: 25, attributeScaling: .wisdom, diceRoll: "1d20+10",
        damageType: .radiant
    )

    // MARK: - Arachne
    static let webWeave = Ability(
        name: "Web Weave", description: "Entangle enemy.", manaCost: 15,
        type: .debuff, power: 0, attributeScaling: .dexterity, diceRoll: "1d6",
        damageType: .physical
    )
    static let poisonBite = Ability(
        name: "Spider Bite", description: "Venomous bite.", manaCost: 15,
        type: .damage, power: 15, attributeScaling: .dexterity, diceRoll: "2d6", damageType: .poison
    )

    // MARK: - Ares
    static let godOfWar = Ability(
        name: "God of War", description: "Massive strength boost.", manaCost: 30,
        type: .buff, power: 20, attributeScaling: .strength, diceRoll: "3d6", damageType: .physical
    )
    static let bloodshed = Ability(
        name: "Bloodshed", description: "Violent combo.", manaCost: 25,
        type: .damage, power: 40, attributeScaling: .strength, diceRoll: "4d6",
        damageType: .physical
    )

    // MARK: - Argus Panoptes
    static let hundredEyesWatch = Ability(
        name: "Hundred Eyes", description: "Cannot be surprised.", manaCost: 0,
        type: .buff, power: 100, attributeScaling: .perception, diceRoll: "1d1",
        damageType: .psychic
    )
    static let giantSmash = Ability(
        name: "Giant Smash", description: "Heavy crush.", manaCost: 20,
        type: .damage, power: 30, attributeScaling: .strength, diceRoll: "3d8",
        damageType: .physical
    )

    // MARK: - Ariadne
    static let goldenThread = Ability(
        name: "Golden Thread", description: "Find the path.", manaCost: 10,
        type: .utility, power: 0, attributeScaling: .wisdom, diceRoll: "1d1", damageType: .radiant
    )

    // MARK: - Arimaspians (One-eyed)
    static let spearThrust = Ability(
        name: "Spear Thrust", description: "Standard attack.", manaCost: 5,
        type: .damage, power: 15, attributeScaling: .strength, diceRoll: "1d8+2",
        damageType: .physical
    )

    // MARK: - Arion (Horse) - PRESERVED
    static let horseKick = Ability(
        name: "Horse Kick", description: "A powerful hoof strike.", manaCost: 10,
        type: .damage, power: 20, attributeScaling: .strength, diceRoll: "2d6+2",
        damageType: .physical
    )
    static let immortalStamina = Ability(
        name: "Immortal Stamina", description: "Drastically increases speed and endurance.",
        manaCost: 15,
        type: .buff, power: 10, attributeScaling: .endurance, diceRoll: "1d6", damageType: .physical
    )

    // MARK: - Aristaeus (Bees & Cheeses) - PRESERVED
    static let beeSwarm = Ability(
        name: "Bee Swarm", description: "Summon a swarm of stinging bees.", manaCost: 15,
        type: .damage, power: 12, attributeScaling: .wisdom, diceRoll: "3d4", damageType: .poison
    )

    // MARK: - Gigantes (Aristaeus 2, Asterius) - PRESERVED
    static let giantCrush = Ability(
        name: "Giant Crush", description: "Massive blunt force trauma.", manaCost: 20,
        type: .damage, power: 25, attributeScaling: .strength, diceRoll: "2d12+5",
        damageType: .physical
    )
    static let dungBeetleForm = Ability(
        name: "Dung Beetle Form", description: "Transform to escape danger.", manaCost: 10,
        type: .utility, power: 5, attributeScaling: .agility, diceRoll: "1d4", damageType: .physical
    )

    // MARK: - Artemis - PRESERVED & EXPANDED
    static let moonArrow = Ability(
        name: "Moon Arrow", description: "A radiant arrow.", manaCost: 25,
        type: .damage, power: 30, attributeScaling: .dexterity, diceRoll: "3d8", damageType: .cold,
        strongAgainst: [.fire, .necrotic]
    )
    static let wildShape = Ability(
        name: "Wild Shape", description: "Take the form of a beast.", manaCost: 20, type: .buff,
        power: 10, attributeScaling: .wisdom, diceRoll: "1d8", damageType: .physical
    )

    // MARK: - Asbeton (Daemon of Charr) - PRESERVED
    static let kilnFire = Ability(
        name: "Kiln Fire", description: "Intense heat used for pottery.", manaCost: 15,
        type: .damage, power: 18, attributeScaling: .intelligence, diceRoll: "2d8",
        damageType: .fire
    )

    // MARK: - Ascalaphus (Underworld) - PRESERVED
    static let owlShriek = Ability(
        name: "Owl Shriek", description: "A terrifying sonic attack.", manaCost: 15, type: .debuff,
        power: 10, attributeScaling: .willpower, diceRoll: "1d8", damageType: .psychic
    )
    static let pomegranateCurse = Ability(
        name: "Pomegranate Curse", description: "Bind enemy to the underworld.", manaCost: 20,
        type: .debuff, power: 15, attributeScaling: .intelligence, diceRoll: "2d6",
        damageType: .necrotic
    )

    // MARK: - River Gods - PRESERVED
    static let riverSurge = Ability(
        name: "River Surge", description: "A crashing wave of river water.", manaCost: 20,
        type: .damage, power: 25, attributeScaling: .constitution, diceRoll: "3d6",
        damageType: .cold,
        strongAgainst: [.fire]
    )
    static let mysianCurrent = Ability(  // Ascanius
        name: "Mysian Current", description: "Restorative waters of Mysia.", manaCost: 15,
        type: .heal, power: 20, attributeScaling: .wisdom, diceRoll: "2d8", damageType: .cold
    )
    static let boeotianFlood = Ability(  // Asopus
        name: "Boeotian Flood", description: "Wide area flood damage.", manaCost: 30, type: .aoe,
        power: 20, attributeScaling: .constitution, diceRoll: "4d6", damageType: .cold
    )
    static let argiveFlow = Ability(  // Asterion
        name: "Argive Flow", description: "Nourishing waters of Argos.", manaCost: 12, type: .buff,
        power: 5, attributeScaling: .constitution, diceRoll: "1d8", damageType: .cold
    )
    static let paeonianSurge = Ability(  // Axius
        name: "Paeonian Surge", description: "Violent river torrent.", manaCost: 22, type: .damage,
        power: 28, attributeScaling: .strength, diceRoll: "3d8", damageType: .force
    )

    // MARK: - Asclepius - PRESERVED
    static let panacea = Ability(
        name: "Panacea", description: "Cure all ailments and heal.", manaCost: 30, type: .heal,
        power: 40, attributeScaling: .wisdom, diceRoll: "4d8", damageType: .radiant
    )
    static let serpentStaff = Ability(
        name: "Serpent Staff", description: "Strike with the rod of Asclepius.", manaCost: 10,
        type: .damage, power: 12, attributeScaling: .strength, diceRoll: "1d8+2",
        damageType: .poison
    )

    // MARK: - Nymphs - PRESERVED
    static let springGrowth = Ability(
        name: "Spring Growth", description: "Accelerate life and healing.", manaCost: 15,
        type: .heal, power: 15, attributeScaling: .wisdom, diceRoll: "2d8", damageType: .radiant
    )
    static let charm = Ability(
        name: "Charm", description: "Lower enemy attack power.", manaCost: 15, type: .debuff,
        power: 5, attributeScaling: .luck, diceRoll: "1d6", damageType: .psychic
    )
    static let poeticInspiration = Ability(  // Ascra
        name: "Poetic Inspiration", description: "Inspire allies.", manaCost: 12, type: .buff,
        power: 8, attributeScaling: .willpower, diceRoll: "1d6", damageType: .psychic
    )
    static let forethoughtGift = Ability(  // Asia
        name: "Forethought Gift", description: "Restore Mana.", manaCost: 10,
        type: .utility, power: 20, attributeScaling: .wisdom, diceRoll: "2d10", damageType: .radiant
    )
    static let starNymphLight = Ability(  // Asterope
        name: "Star Nymph Light", description: "Guiding starlight.", manaCost: 10,
        type: .utility, power: 5, attributeScaling: .wisdom, diceRoll: "1d4", damageType: .radiant
    )
    static let caucasianFrost = Ability(  // Asterodeia
        name: "Caucasian Frost", description: "Mountain cold.", manaCost: 15, type: .damage,
        power: 18, attributeScaling: .constitution, diceRoll: "2d8", damageType: .cold
    )
    static let glenWhisper = Ability(  // Auloniades
        name: "Glen Whisper", description: "Sleep.", manaCost: 20, type: .debuff,
        power: 0, attributeScaling: .willpower, diceRoll: "1d20", damageType: .psychic
    )
    static let treeBarkSkin = Ability(  // Atlanteia
        name: "Tree Bark Skin", description: "Harden skin.", manaCost: 12, type: .buff,
        power: 8, attributeScaling: .endurance, diceRoll: "1d8", damageType: .physical
    )

    // MARK: - Stars & Titans - PRESERVED
    static let starFall = Ability(
        name: "Star Fall", description: "Call down falling stars.", manaCost: 20, type: .damage,
        power: 20, attributeScaling: .intelligence, diceRoll: "2d10", damageType: .radiant
    )
    static let quailFlight = Ability(  // Asteria
        name: "Quail Flight", description: "Transform into a quail.", manaCost: 15, type: .buff,
        power: 20, attributeScaling: .agility, diceRoll: "1d10", damageType: .physical
    )
    static let planetaryOrbit = Ability(  // Astra Planeta
        name: "Planetary Orbit", description: "Shield of orbiting stars.", manaCost: 25,
        type: .buff, power: 15, attributeScaling: .intelligence, diceRoll: "2d6",
        damageType: .radiant
    )
    static let windGust = Ability(  // Astraeus
        name: "Wind Gust", description: "Buffeting wind.", manaCost: 10, type: .damage,
        power: 12, attributeScaling: .agility, diceRoll: "1d8", damageType: .force
    )
    static let lightningBolt = Ability(  // Astrape
        name: "Lightning Bolt", description: "Divine lightning.", manaCost: 20,
        type: .damage, power: 25, attributeScaling: .intelligence, diceRoll: "3d6+2",
        damageType: .lightning
    )
    static let constellationForm = Ability(  // Astrothesiai
        name: "Constellation Form", description: "Become stars.", manaCost: 30, type: .buff,
        power: 20, attributeScaling: .willpower, diceRoll: "1d12", damageType: .radiant
    )

    // MARK: - Astraea (Justice) - PRESERVED
    static let justiceStrike = Ability(
        name: "Justice Strike", description: "Divine retribution.", manaCost: 20,
        type: .damage, power: 30, attributeScaling: .wisdom, diceRoll: "1d20", damageType: .radiant
    )

    // MARK: - Ate (Folly) - PRESERVED
    static let blindFolly = Ability(
        name: "Blind Folly", description: "Cloud the mind.", manaCost: 15,
        type: .debuff, power: 0, attributeScaling: .luck, diceRoll: "1d4", damageType: .psychic
    )
    static let ruinousDelusion = Ability(
        name: "Ruinous Delusion", description: "Self-harm.", manaCost: 25,
        type: .debuff, power: 15, attributeScaling: .luck, diceRoll: "2d6", damageType: .psychic
    )

    // MARK: - Athena - PRESERVED
    static let strategy = Ability(
        name: "Strategy", description: "Analyze weakness.", manaCost: 15, type: .buff,
        power: 10, attributeScaling: .intelligence, diceRoll: "1d6", damageType: .psychic
    )
    static let aegisDeflect = Ability(
        name: "Aegis Deflect", description: "Perfect defense.", manaCost: 30,
        type: .buff, power: 50, attributeScaling: .wisdom, diceRoll: "1d20", damageType: .radiant
    )

    // MARK: - Atlas / Atlantis - PRESERVED
    static let skyBurden = Ability(  // Atlas
        name: "Sky Burden", description: "Crush with sky weight.", manaCost: 40,
        type: .damage, power: 45, attributeScaling: .strength, diceRoll: "4d10", damageType: .force
    )
    static let sunkenWrath = Ability(  // Atlantis
        name: "Sunken Wrath", description: "Power of lost civilization.", manaCost: 35,
        type: .damage, power: 35, attributeScaling: .constitution, diceRoll: "3d10",
        damageType: .necrotic  // Water
    )

    // MARK: - Atropus (Fate) - PRESERVED
    static let fateCut = Ability(
        name: "Fate Cut", description: "Sever lifeline.", manaCost: 40, type: .damage,
        power: 50, attributeScaling: .willpower, diceRoll: "1d100", damageType: .necrotic
    )
    static let inevitableEnd = Ability(
        name: "Inevitable End", description: "Doom.", manaCost: 50, type: .debuff,
        power: 100, attributeScaling: .willpower, diceRoll: "1d1", damageType: .necrotic
    )

    // MARK: - Attis - PRESERVED
    static let frenziedDance = Ability(
        name: "Frenzied Dance", description: "Wild dance.", manaCost: 15,
        type: .buff, power: 15, attributeScaling: .agility, diceRoll: "2d6", damageType: .physical
    )

    // MARK: - Horas - PRESERVED
    static let dawnLight = Ability(  // Auge
        name: "Dawn Light", description: "Reveal hidden.", manaCost: 10, type: .utility,
        power: 5, attributeScaling: .perception, diceRoll: "1d4", damageType: .radiant
    )
    static let growthSurge = Ability(  // Auxesia
        name: "Growth Surge", description: "Rapid growth.", manaCost: 15, type: .damage,
        power: 12, attributeScaling: .wisdom, diceRoll: "2d6", damageType: .poison
    )

    // MARK: - Automatones - PRESERVED
    static let automatonCrush = Ability(
        name: "Automaton Crush", description: "Crushing blow.", manaCost: 20,
        type: .damage, power: 25, attributeScaling: .strength, diceRoll: "2d12", damageType: .force
    )
    static let metalBody = Ability(
        name: "Metal Body", description: "Impervious.", manaCost: 20, type: .buff,
        power: 20, attributeScaling: .endurance, diceRoll: "2d8", damageType: .physical
    )

    // MARK: - General / Shared - PRESERVED
    static let aimedShot = Ability(
        name: "Aimed Shot", description: "Precise shot.", manaCost: 10, type: .damage,
        power: 15, attributeScaling: .dexterity, diceRoll: "1d8+4", damageType: .physical
    )
    static let smite = Ability(
        name: "Smite", description: "Powerful strike.", manaCost: 10, type: .damage,
        power: 15, attributeScaling: .strength, diceRoll: "1d8+2", damageType: .physical
    )
    static let heal = Ability(
        name: "Heal", description: "Restore health.", manaCost: 15, type: .heal,
        power: 20, attributeScaling: .wisdom, diceRoll: "2d8+5", damageType: .radiant
    )
    static let warCry = Ability(
        name: "War Cry", description: "Boost Strength.", manaCost: 10, type: .buff,
        power: 5, attributeScaling: .strength, diceRoll: "1d4", damageType: .physical
    )
    static let swiftness = Ability(
        name: "Swiftness", description: "Increase Speed.", manaCost: 10, type: .buff,
        power: 5, attributeScaling: .agility, diceRoll: "1d4", damageType: .physical
    )
    static let shieldBash = Ability(
        name: "Shield Bash", description: "Stun enemy.", manaCost: 12, type: .damage,
        power: 10, attributeScaling: .strength, diceRoll: "1d6", damageType: .physical
    )
    static let stealthStrike = Ability(
        name: "Stealth Strike", description: "Sneak attack.", manaCost: 12, type: .damage,
        power: 20, attributeScaling: .dexterity, diceRoll: "2d6", damageType: .physical
    )
    static let ironSkin = Ability(
        name: "Iron Skin", description: "Increase defense.", manaCost: 12, type: .buff,
        power: 5, attributeScaling: .endurance, diceRoll: "1d6", damageType: .physical
    )
    static let prophecy = Ability(
        name: "Prophecy", description: "Predict movements.", manaCost: 20, type: .buff,
        power: 10, attributeScaling: .perception, diceRoll: "1d4", damageType: .psychic
    )
    static let amazonStrike = Ability(
        name: "Amazon Strike", description: "Fierce blow.", manaCost: 10, type: .damage,
        power: 15, attributeScaling: .strength, diceRoll: "1d10+2", damageType: .physical
    )
}
