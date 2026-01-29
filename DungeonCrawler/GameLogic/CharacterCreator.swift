//
//  CharacterCreator.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/29/26.
//

import Foundation

class CharacterCreator {

    // Generates a pool of bonus points (Range 10-25 for broad options)
    static func rollBonusPoints() -> Int {
        return Int.random(in: 10...25)
    }

    // Tries to create a character. Returns nil if bonus points are insufficient for the profession.
    static func createCharacter(name: String, sex: Sex, profession: Profession, bonusPoints: Int)
        -> PartyMember?
    {
        // 1. Start with Base 6
        var currentAttributes = Attributes(
            strength: 6, endurance: 6, agility: 6, speed: 6, intelligence: 6, wisdom: 6,
            dexterity: 6, constitution: 6, perception: 6, luck: 6, willpower: 6
        )

        // 2. Calculate Cost to meet Minimums
        var cost = 0
        let reqs = profession.requiredAttributes

        // Helper to calc difference
        func calcDiff(_ current: Int, _ required: Int) -> Int {
            return max(0, required - current)
        }

        cost += calcDiff(currentAttributes.strength, reqs.strength)
        cost += calcDiff(currentAttributes.endurance, reqs.endurance)
        cost += calcDiff(currentAttributes.agility, reqs.agility)
        cost += calcDiff(currentAttributes.speed, reqs.speed)
        cost += calcDiff(currentAttributes.intelligence, reqs.intelligence)
        cost += calcDiff(currentAttributes.wisdom, reqs.wisdom)
        cost += calcDiff(currentAttributes.dexterity, reqs.dexterity)
        cost += calcDiff(currentAttributes.constitution, reqs.constitution)
        cost += calcDiff(currentAttributes.perception, reqs.perception)
        cost += calcDiff(currentAttributes.luck, reqs.luck)
        cost += calcDiff(currentAttributes.willpower, reqs.willpower)

        // 3. Check Affordability
        if cost > bonusPoints {
            print("Failed to create \(name): Need \(cost) points, rolled \(bonusPoints).")
            return nil
        }

        // 4. Apply Minimums
        currentAttributes.strength = max(currentAttributes.strength, reqs.strength)
        currentAttributes.endurance = max(currentAttributes.endurance, reqs.endurance)
        currentAttributes.agility = max(currentAttributes.agility, reqs.agility)
        currentAttributes.speed = max(currentAttributes.speed, reqs.speed)
        currentAttributes.intelligence = max(currentAttributes.intelligence, reqs.intelligence)
        currentAttributes.wisdom = max(currentAttributes.wisdom, reqs.wisdom)
        currentAttributes.dexterity = max(currentAttributes.dexterity, reqs.dexterity)
        currentAttributes.constitution = max(currentAttributes.constitution, reqs.constitution)
        currentAttributes.perception = max(currentAttributes.perception, reqs.perception)
        currentAttributes.luck = max(currentAttributes.luck, reqs.luck)
        currentAttributes.willpower = max(currentAttributes.willpower, reqs.willpower)

        // 5. Spend Remaining Points (Weighted towards class requirements)
        // Identify preferred attributes (those that had a requirement > 0)
        var preferredAttributes: [AttributeType] = []
        for attr in AttributeType.allCases {
            if reqs[attr] > 0 {
                preferredAttributes.append(attr)
            }
        }

        var remaining = bonusPoints - cost
        while remaining > 0 {
            // Decision: Boost a preferred stat (70%) or a random stat (30%)
            // If no preferred stats (all 0), always random.
            let pickPreferred = !preferredAttributes.isEmpty && Int.random(in: 1...100) <= 70

            let targetAttr: AttributeType
            if pickPreferred {
                targetAttr = preferredAttributes.randomElement()!
            } else {
                targetAttr = AttributeType.allCases.randomElement()!
            }

            // Increment
            currentAttributes[targetAttr] += 1
            remaining -= 1
        }

        // 6. Resolve Sex/Gender (Mutation Check)
        var finalSex = sex
        if Int.random(in: 1...100) == 1 {
            // 1% Chance
            finalSex = .hermaphrodite
            print("\(name) was born a Hermaphrodite!")
        }

        // 7. Initialize Member
        let member = PartyMember(
            name: name, sex: finalSex, profession: profession, attributes: currentAttributes)

        return member
    }
}
