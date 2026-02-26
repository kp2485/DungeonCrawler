//
//  GameView.swift
//  DungeonCrawler
//
//  Created by Maarten Engels on 22/02/2025.
//

import Combine
import RealityKit
import SwiftUI

struct GameView: NSViewRepresentable {
    let world: World

    func makeNSView(context: Context) -> ARView {
        let view = ARView()

        setupView(view)

        WorldUpdateSystem.registerSystem()
        MapUpdateSystem.registerSystem()
        EnemyUpdateSystem.registerSystem()

        return view

    }

    func updateNSView(_ nsView: NSViewType, context: Context) {
        // doesn't need anything yet
    }

    private func setupView(_ arView: ARView) {
        guard let skyboxResource = try? EnvironmentResource.load(named: "ambientLight") else {
            fatalError("Unable to load skybox resource")
        }

        arView.environment.background = .color(.black)
        arView.environment.lighting.resource = skyboxResource

        let camera = PerspectiveCamera()
        // Provide a wider field of view to see more of the environment
        camera.camera.fieldOfViewInDegrees = 90

        let cameraAnchor = AnchorEntity(world: .zero)
        cameraAnchor.addChild(camera)
        cameraAnchor.name = "CameraAnchor"

        // Move the camera up to eye level, assuming floor is near 0 and walls are 1.0 high
        cameraAnchor.position.y = 0.5

        arView.scene.addAnchor(cameraAnchor)

        let lightEntity = PointLight()
        cameraAnchor.addChild(lightEntity)

        let worldEntity = Entity(components: [WorldComponent(world: world)])
        worldEntity.name = "WorldEntity"
        let worldAnchor = AnchorEntity(world: .zero)
        worldAnchor.addChild(worldEntity)
        arView.scene.addAnchor(worldAnchor)
    }
}
