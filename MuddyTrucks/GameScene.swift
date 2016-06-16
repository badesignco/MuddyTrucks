//
//  GameScene.swift
//  MuddyTrucks
//
//  Created by Ben Murphy on 6/16/16.
//  Copyright (c) 2016 Constellation Software. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {

    var truckLayer = SKNode()
    var mudLayer = SKNode()
    var truck = TruckNode()

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        truckLayer = childNodeWithName("TruckLayer")!
        mudLayer = childNodeWithName("MudLayer")!

        truckLayer.addChild(truck)
        mudLayer.addChild(MudNode.init(size: 15.0))

        physicsWorld.contactDelegate = self

    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        (mudLayer.children as! [MudNode]).forEach {
            $0.applyFriction()
        }
    }
}

// MARK: - GameScene will be the delegate for SKPhysicsWorld
extension GameScene: SKPhysicsContactDelegate {

    func didBeginContact(contact: SKPhysicsContact) {
        guard
            let nodeA = contact.bodyA.node as? Contactable,
            let nodeB = contact.bodyB.node as? Contactable
            else { return }

        nodeA.contactDidBegin(nodeB as Contactable)
        nodeB.contactDidBegin(nodeA as Contactable)

    }

    func didEndContact(contact: SKPhysicsContact) {
        guard
            let nodeA = contact.bodyA.node as? Contactable,
            let nodeB = contact.bodyB.node as? Contactable
            else { return }

        nodeA.contactDidEnd(nodeB as Contactable)
        nodeB.contactDidEnd(nodeA as Contactable)
    }
}