import Foundation

enum InteractionMethod: String, CaseIterable, Identifiable {
    case bash = "Bash"
    case pick = "Pick Lock"
    case spell = "Spell"
    case item = "Use Item"

    var id: String { rawValue }
}
