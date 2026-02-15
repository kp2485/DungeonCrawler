# Test Dungeon Map Location

The test dungeon map is defined in **`MainCoordinator.swift`**, inside the `makeInitialWorld()` function (lines 47-117).

It uses a string array representation where:

- `#` = Wall
- `.` = Floor
- `S` = Start Position
- `C` = Chest (ChestState.closed)
- `L` = Locked Door (DoorState.locked)

The code also programmatically adds a "Gold Key" to the chest at (5,4) and locks the door at (5,5) with a matching ID.
