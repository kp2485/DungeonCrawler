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

                let tile = world.currentFloor.tileAt(coordinate)
                var isWalkable = tile != .wall
                if let object = world.currentFloor.objects[coordinate] {
                    if case .door = object.state {
                        isWalkable = true
                    }
                }

                if isWalkable {
                    // Floors and Ceilings
                    mapAnchor?.addChild(
                        placeModelAt(model: "FloorTile", worldPosition: coordinate.toSIMD3))
                    mapAnchor?.addChild(
                        placeModelAt(model: "CeilingTile", worldPosition: coordinate.toSIMD3))

                    // Boundary walls
                    let directions: [CompassDirection] = [.north, .east, .south, .west]
                    for dir in directions {
                        let neighborCoord = coordinate + dir.toCoordinate
                        let neighborTile = world.currentFloor.tileAt(neighborCoord)
                        var neighborWalkable = neighborTile != .wall
                        if let nObj = world.currentFloor.objects[neighborCoord] {
                            if case .door = nObj.state {
                                neighborWalkable = true
                            }
                        }

                        if !neighborWalkable {
                            mapAnchor?.addChild(
                                placeBoundaryWall(at: coordinate.toSIMD3, direction: dir))
                        }
                    }
                }

                switch tile {
                case .stairsUp:
                    mapAnchor?.addChild(
                        placeModelAt(model: "stairsUp", worldPosition: coordinate.toSIMD3))
                case .stairsDown:
                    mapAnchor?.addChild(
                        placeModelAt(model: "stairsDown", worldPosition: coordinate.toSIMD3))
                case .winTarget:
                    mapAnchor?.addChild(
                        placeModelAt(model: "target", worldPosition: coordinate.toSIMD3))
                default:
                    break
                }

                // Render Interactive Objects
                if let object = world.currentFloor.objects[coordinate] {
                    switch object.state {
                    case .door(let state):
                        // Orientation Check
                        var orientation = simd_quatf(angle: 0, axis: [0, 1, 0])
                        let left = Coordinate(x: col - 1, y: row)
                        let right = Coordinate(x: col + 1, y: row)
                        let up = Coordinate(x: col, y: row + 1)
                        let down = Coordinate(x: col, y: row - 1)

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

    private func placeBoundaryWall(at worldPosition: SIMD3<Float>, direction: CompassDirection)
        -> AnchorEntity
    {
        let wallAnchor = AnchorEntity(world: worldPosition)
        let wallEntity = createCube(worldPosition: .zero, color: .lightGray, size: 1.0).children[0]
        wallEntity.scale = SIMD3<Float>(1.0, 1.0, 0.05)
        wallEntity.position.y = 0.5

        switch direction {
        case .north:
            wallEntity.position.z = -0.5
        case .south:
            wallEntity.position.z = 0.5
        case .east:
            wallEntity.position.x = 0.5
            wallEntity.orientation = simd_quatf(angle: .pi / 2, axis: [0, 1, 0])
        case .west:
            wallEntity.position.x = -0.5
            wallEntity.orientation = simd_quatf(angle: .pi / 2, axis: [0, 1, 0])
        }

        wallAnchor.addChild(wallEntity)
        return wallAnchor
    }

    private func placeModelAt(
        model: String, worldPosition: SIMD3<Float>, orientation: simd_quatf? = nil
    ) -> AnchorEntity {
        let entity: Entity

        switch model {
        case "FloorTile":
            entity = createCube(worldPosition: .zero, color: .darkGray, size: 1.0).children[0]
            entity.scale = SIMD3<Float>(1.0, 0.05, 1.0)
            entity.position.y = -0.025
        case "CeilingTile":
            entity = createCube(worldPosition: .zero, color: .darkGray, size: 1.0).children[0]
            entity.scale = SIMD3<Float>(1.0, 0.05, 1.0)
            entity.position.y = 1.025
        case "Door_Closed":
            entity = createCube(worldPosition: .zero, color: .brown, size: 1.0).children[0]
            entity.scale = SIMD3<Float>(1.0, 1.0, 0.2)
            entity.position.y = 0.5
        case "Door_Open":
            entity =
                createCube(worldPosition: .zero, color: .brown.withAlphaComponent(0.5), size: 1.0)
                .children[0]
            entity.scale = SIMD3<Float>(0.2, 1.0, 1.0)
            entity.position.y = 0.5
            entity.position.x = -0.4
        case "Chest_Closed":
            entity = createCube(worldPosition: .zero, color: .yellow, size: 0.5).children[0]
            entity.position.y = 0.25
        case "Chest_Open":
            entity = createCube(worldPosition: .zero, color: .lightGray, size: 0.5).children[0]
            entity.position.y = 0.25
        case "stairsUp":
            entity = createCube(worldPosition: .zero, color: .cyan, size: 0.5).children[0]
            entity.position.y = 0.25
        case "stairsDown":
            entity = createCube(worldPosition: .zero, color: .magenta, size: 0.5).children[0]
            entity.position.y = 0.25
        case "target":
            entity = createCube(worldPosition: .zero, color: .green, size: 0.5).children[0]
            entity.position.y = 0.25
        default:
            entity = createCube(worldPosition: .zero, color: .red).children[0]
        }

        let anchor = AnchorEntity(world: worldPosition)
        let clonedEntity = entity.clone(recursive: true)

        if let orientation = orientation {
            clonedEntity.orientation = orientation
        }

        anchor.addChild(clonedEntity)

        return anchor
    }
}
