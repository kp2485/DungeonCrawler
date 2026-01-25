//
//  WorldUpdateSystem.swift
//  DungeonCrawler
//
//  Created by Kyle Peterson on 1/24/26.
//

import RealityKit

struct WorldComponent: Component {
    let world: World
}

class WorldUpdateSystem: System {
    var world: World!
    var cameraAnchor: AnchorEntity!
    
    required init(scene: Scene) {
        guard let worldEntity = scene.findEntity(named: "WorldEntity") else {
            fatalError("Can't find WorldEntity in scene")
        }
        
        let worldComponents = worldEntity.components.compactMap { $0 as? WorldComponent }
        
        guard let worldComponent = worldComponents.first else {
            fatalError("No WorldComponent found on WorldEntity")
        }
        
        self.world = worldComponent.world
        
        guard let cameraAnchor = scene.findEntity(named: "CameraAnchor") as? AnchorEntity else {
            fatalError("Can't find CameraAnchor in scene")
        }
        
        self.cameraAnchor = cameraAnchor
        
    }
    
    func update(context: SceneUpdateContext) {
        cameraAnchor.position = world.playerPosition
    }
    
}
