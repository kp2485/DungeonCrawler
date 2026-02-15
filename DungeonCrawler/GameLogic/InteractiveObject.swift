import Foundation

enum InteractiveObjectState: Equatable, Hashable {
    case door(DoorState)
    case chest(ChestState)
}

enum DoorState: Equatable, Hashable {
    case open
    case closed
    case locked(difficulty: Int, keyId: Int?)
}

enum ChestState: Equatable, Hashable {
    case open
    case closed
    case locked(difficulty: Int, keyId: Int?)
}

struct InteractiveObject: Identifiable, Equatable, Hashable {
    let id: UUID
    var state: InteractiveObjectState
    var content: [Item]  // For chests, or maybe keys in doors?

    // Helper accessors
    var isBlockingMovement: Bool {
        switch state {
        case .door(let s):
            return s != .open
        case .chest:
            return true  // Chests always block movement? Or can you walk on them? Let's say block for now.
        }
    }

    var isBlockingSight: Bool {
        switch state {
        case .door(let s):
            return s != .open  // Open doors allow sight
        case .chest:
            return false  // Chests are low, don't block sight
        }
    }

    init(state: InteractiveObjectState, content: [Item] = []) {
        self.id = UUID()
        self.state = state
        self.content = content
    }
}
