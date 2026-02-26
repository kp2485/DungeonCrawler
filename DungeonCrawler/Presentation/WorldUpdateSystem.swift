//
//  WorldUpdateSystem.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 22/02/2025.
//

import RealityKit
import SwiftUI

class WorldUpdateSystem: System {
    var world: World!
    var cameraAnchor: AnchorEntity!

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

        guard let cameraAnchor = scene.findEntity(named: "CameraAnchor") as? AnchorEntity else {
            fatalError("Can't find CameraAnchor in scene.")
        }

        self.cameraAnchor = cameraAnchor
    }

    func update(context: SceneUpdateContext) {
        world.update(at: Date())

        var targetPosition = world.partyPosition.toSIMD3
        targetPosition.y = 0.5

        let targetRotation = world.partyHeading.toFloatQuaternion

        let deltaTime = Float(context.deltaTime)
        let moveSpeed: Float = 10.0  // adjust for preferred speed
        let rotateSpeed: Float = 10.0

        let currentPosition = cameraAnchor.position
        let tPosition = min(1.0, deltaTime * moveSpeed)
        cameraAnchor.position = currentPosition + (targetPosition - currentPosition) * tPosition

        let currentRotation = cameraAnchor.transform.rotation
        let tRotation = min(1.0, deltaTime * rotateSpeed)
        cameraAnchor.transform.rotation = simd_slerp(currentRotation, targetRotation, tRotation)
    }
}
