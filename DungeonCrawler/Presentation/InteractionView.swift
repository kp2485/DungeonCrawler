import SwiftUI

struct InteractionView: View {
    @ObservedObject var viewModel: ViewModel

    @State private var selectedMethod: InteractionMethod = .bash
    @State private var selectedMemberId: UUID?

    var body: some View {
        ZStack {
            Color.black.opacity(0.8)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 20) {
                // Header
                Text("INTERACTION")
                    .font(.title)
                    .foregroundColor(.wizGold)
                    .shadow(color: .black, radius: 2)

                if let object = viewModel.interactionObject {
                    Text(displayString(for: object))
                        .font(.headline)
                        .foregroundColor(.stoneLight)
                }

                Divider().background(Color.stoneMid)

                // Method Selection
                HStack(spacing: 12) {
                    ForEach(InteractionMethod.allCases) { method in
                        InteractionMethodButton(
                            method: method,
                            isSelected: selectedMethod == method
                        ) {
                            selectedMethod = method
                        }
                    }
                }

                Divider().background(Color.stoneMid)

                // Party Member Selection
                Text("WHO WILL TRY?")
                    .font(.caption)
                    .foregroundColor(.stoneMid)

                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(viewModel.world.partyMembers.alivePartyMembers, id: \.id) {
                            member in
                            PartyMemberSelectionCard(
                                member: member,
                                isSelected: selectedMemberId == member.id
                            ) {
                                selectedMemberId = member.id
                            }
                        }
                    }
                    .padding()
                }
                .frame(height: 120)

                // Action Button
                RetroButton(label: "ATTEMPT") {
                    if let target = viewModel.interactionTarget,
                        let memberId = selectedMemberId,
                        let member = viewModel.world.partyMembers.allPartyMembers.first(where: {
                            $0.id == memberId
                        })
                    {

                        viewModel.world.interact(
                            with: target, method: selectedMethod, member: member)
                        viewModel.isInteracting = false
                    }
                }
                .disabled(selectedMemberId == nil)
                .opacity(selectedMemberId == nil ? 0.5 : 1.0)

                Button("CANCEL") {
                    viewModel.isInteracting = false
                }
                .foregroundColor(.wizRed)
                .padding(.top, 10)
            }
            .padding()
            .background(StoneBackground())
            .overlay(BevelBorder(width: 3, reversed: false))
            .frame(maxWidth: 500)
            .padding()
        }
        .onAppear {
            // Default select leader
            selectedMemberId = viewModel.world.partyMembers.alivePartyMembers.first?.id
        }
    }

    func displayString(for object: InteractiveObject) -> String {
        switch object.state {
        case .door(let state):
            switch state {
            case .open: return "Open Door"
            case .closed: return "Closed Door"
            case .locked(let diff, _): return "Locked Door (Diff: \(diff))"
            }
        case .chest(let state):
            switch state {
            case .open: return "Open Chest"
            case .closed: return "Closed Chest"
            case .locked(let diff, _): return "Locked Chest (Diff: \(diff))"
            }
        }
    }
}

struct InteractionMethodButton: View {
    let method: InteractionMethod
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                // Icon mapping
                Image(systemName: iconName(for: method))
                    .font(.system(size: 24))
                    .foregroundColor(isSelected ? .wizGold : .stoneLight)

                Text(method.rawValue.uppercased())
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundColor(isSelected ? .white : .stoneMid)
            }
            .frame(width: 80, height: 80)
            .background(isSelected ? Color.stoneDark : Color.black.opacity(0.3))
            .overlay(BevelBorder(width: 2, reversed: isSelected))
        }
        .buttonStyle(PlainButtonStyle())
    }

    func iconName(for method: InteractionMethod) -> String {
        switch method {
        case .bash: return "hammer.fill"
        case .pick: return "lock.open.fill"
        case .spell: return "wand.and.stars"
        case .item: return "key.fill"
        }
    }
}

struct PartyMemberSelectionCard: View {
    let member: PartyMember
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                // Avatar placeholder
                Circle().fill(Color.stoneLight).frame(width: 40, height: 40)
                    .overlay(Text(String(member.name.prefix(1))).foregroundColor(.black))

                Text(member.name)
                    .font(.caption)
                    .foregroundColor(isSelected ? .wizGold : .white)

                // Specific stats relevant to interaction could go here
            }
            .frame(width: 80, height: 100)
            .background(isSelected ? Color.stoneDark : Color.black.opacity(0.5))
            .overlay(BevelBorder(width: 2, reversed: isSelected))
        }
        .buttonStyle(PlainButtonStyle())
    }
}
