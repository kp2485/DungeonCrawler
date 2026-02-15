//
//  WorldUpdateSystem.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 22/02/2025.
//

import Combine
import RealityKit
import SwiftUI

struct WorldComponent: Component {
    let world: World
}

class MapUpdateSystem: System {
    var world: World!
    private var currentRenderedFloor: Map?
    private var mapAnchor: AnchorEntity?
    private var modelCache = [String: Entity]()

    // Initializer is required. Use an empty implementation if there's no setup needed.
    required init(scene: RealityKit.Scene) {
        guard let worldEntity = scene.findEntity(named: "WorldEntity") else {
            fatalError("Can't find WorldEntity in scene.")
        }

        let worldComponents = worldEntity.components.compactMap { $0 as? WorldComponent }

        guard let worldComponent = worldComponents.first else {
            fatalError("No WorldComponent found on WorldEntity")
        }

        self.world = worldComponent.world
    }

    func update(context: SceneUpdateContext) {
        if currentRenderedFloor != world.currentFloor {
            renderMap(scene: context.scene)
        }
    }

    private func renderMap(scene: RealityKit.Scene) {
        if let mapAnchor {
            scene.removeAnchor(mapAnchor)
        }

        mapAnchor = AnchorEntity(world: .zero)
        scene.addAnchor(mapAnchor!)
        currentRenderedFloor = world.currentFloor

        for row in world.currentFloor.minY...world.currentFloor.maxY {
            for col in world.currentFloor.minX...world.currentFloor.maxX {
                let coordinate = Coordinate(x: col, y: row)

                // Check for objects that might replace the wall (e.g. Doors)
                var skipWallRendering = false
                if let object = world.currentFloor.objects[coordinate] {
                    if case .door = object.state {
                        skipWallRendering = true
                    }
                }

                switch world.currentFloor.tileAt(coordinate) {
                case .wall:
                    if !skipWallRendering {
                        mapAnchor?.addChild(
                            placeModelAt(model: "Wall", worldPosition: coordinate.toSIMD3))
                    }
                case .stairsUp:
                    mapAnchor?.addChild(
                        placeModelAt(model: "stairsUp", worldPosition: coordinate.toSIMD3))
                case .stairsDown:
                    mapAnchor?.addChild(
                        placeModelAt(model: "stairsDown", worldPosition: coordinate.toSIMD3))
                case .winTarget:
                    mapAnchor?.addChild(
                        placeModelAt(model: "FloorTile", worldPosition: coordinate.toSIMD3))
                    mapAnchor?.addChild(
                        placeModelAt(model: "target", worldPosition: coordinate.toSIMD3))
                default:
                    mapAnchor?.addChild(
                        placeModelAt(model: "FloorTile", worldPosition: coordinate.toSIMD3))
                }

                // Render Interactive Objects
                if let object = world.currentFloor.objects[coordinate] {
                    switch object.state {
                    case .door(let state):
                        // Orientation Check
                        // Check North/South for Walls. If Walls are N/S, then Door is East/West (default?)
                        // Usually:
                        // If Walls are East/West (x-1, x+1), door faces South (default).
                        // If Walls are North/South (y-1, y+1), door faces East (rotated 90).

                        var orientation = simd_quatf(angle: 0, axis: [0, 1, 0])
                        let left = Coordinate(x: col - 1, y: row)
                        let right = Coordinate(x: col + 1, y: row)
                        let up = Coordinate(x: col, y: row + 1)
                        let down = Coordinate(x: col, y: row - 1)

                        // Heuristic: If we have walls to Left/Right, we are a "Horizontal" hallway (East-West), so the door cuts it vertically?
                        // Wait.
                        // Hallway: #.#
                        // Door in middle: #+#
                        // Movement is Left-Right. Door faces Left (or Right).
                        // Plane of door is typically perpendicular to movement.
                        // So if movement is East-West, Door Plane is North-South.
                        // If movement is North-South, Door Plane is East-West.

                        // Let's assume default model is "Door in a Wall running East-West", so facing North/South.

                        // Check tiles:
                        let isWallLeft = world.currentFloor.tileAt(left) == .wall
                        let isWallRight = world.currentFloor.tileAt(right) == .wall

                        // If walls are Left and Right, the "Wall" line is Horizontal. The Door fits into that Wall.
                        // So the Door Plane is East-West. (Facing North/South).
                        // If walls are Up and Down, the "Wall" line is Vertical. The Door fits into that Wall.
                        // So the Door Plane is North-South. (Facing East/West).

                        // My heuristics might be flipped depending on model. Let's try:
                        // If walls are Up/Down (Vertical Wall), rotate 90.
                        let isWallUp = world.currentFloor.tileAt(up) == .wall
                        let isWallDown = world.currentFloor.tileAt(down) == .wall

                        if isWallUp || isWallDown {
                            orientation = simd_quatf(angle: .pi / 2, axis: [0, 1, 0])
                        }

                        if case .open = state {
                            mapAnchor?.addChild(
                                placeModelAt(
                                    model: "Door_Open", worldPosition: coordinate.toSIMD3,
                                    orientation: orientation))
                        } else {
                            mapAnchor?.addChild(
                                placeModelAt(
                                    model: "Door_Closed", worldPosition: coordinate.toSIMD3,
                                    orientation: orientation))
                        }
                    case .chest(let state):
                        if case .open = state {
                            mapAnchor?.addChild(
                                placeModelAt(model: "Chest_Open", worldPosition: coordinate.toSIMD3)
                            )
                        } else {
                            mapAnchor?.addChild(
                                placeModelAt(
                                    model: "Chest_Closed", worldPosition: coordinate.toSIMD3))
                        }
                    }
                }
            }
        }
    }

    private func createCube(worldPosition: SIMD3<Float>, color: NSColor = .blue, size: Float = 0.8)
        -> AnchorEntity
    {
        var cubeMaterial = SimpleMaterial(color: color, isMetallic: false)
        if color == .brown {
            cubeMaterial.roughness = 0.8
        } else if color == .yellow {
            cubeMaterial.metallic = 0.8
            cubeMaterial.roughness = 0.2
        }

        let cubeEntity = Entity(components: [
            ModelComponent(mesh: .generateBox(size: size), materials: [cubeMaterial])
        ])
        let cubeAnchor = AnchorEntity(world: worldPosition)
        cubeAnchor.addChild(cubeEntity)

        return cubeAnchor
    }

    private func placeModelAt(
        model: String, worldPosition: SIMD3<Float>, orientation: simd_quatf? = nil
    ) -> AnchorEntity {
        // Fallback or Load
        let entity: Entity

        if let loaded = loadEntity(model: model) {
            entity = loaded
        } else {
            // Specific Programmatic Fallbacks
            switch model {
            case "Door_Closed":
                entity = createCube(worldPosition: .zero, color: .brown, size: 0.9).children[0]
            case "Door_Open":
                // Open door: Thinner, maybe offset? Or just a frame?
                // For now, a thin slab to the side or transparent?
                // Let's make it a thin "Open" slab.
                entity =
                    createCube(
                        worldPosition: .zero, color: .brown.withAlphaComponent(0.5), size: 0.9
                    ).children[0]
                // Scale it to look like an open door against the wall?
                // Complex without full model. Let's just make it a smaller/different color cube.
                entity.scale = SIMD3<Float>(0.1, 1.0, 1.0)  // Thin slice
            case "Chest_Closed":
                entity = createCube(worldPosition: .zero, color: .yellow, size: 0.5).children[0]
            case "Chest_Open":
                entity = createCube(worldPosition: .zero, color: .gray, size: 0.5).children[0]
            default:
                entity = createCube(worldPosition: .zero, color: .gray).children[0]
            }
        }

        let anchor = AnchorEntity(world: worldPosition)
        let clonedEntity = entity.clone(recursive: true)

        if let orientation = orientation {
            clonedEntity.orientation = orientation
        }

        anchor.addChild(clonedEntity)

        return anchor
    }

    private func loadEntity(model: String) -> Entity? {
        if let entity = modelCache[model] {
            return entity
        }

        // Try loading
        if let entity = try? Entity.load(named: model) {
            modelCache[model] = entity
            return entity
        }

        // Only warn if it's NOT one of our known programmatic fallbacks
        let knownMissing = ["Door_Closed", "Door_Open", "Chest_Closed", "Chest_Open"]
        if !knownMissing.contains(model) {
            print("Warning: Failed to load model - \(model)")
        }
        return nil
    }
}
