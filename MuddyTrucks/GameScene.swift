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
    var hose = SKEmitterNode()
    let textures = SKTextureAtlas(named: "Splats")

    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        truckLayer = childNodeWithName("TruckLayer")!
        mudLayer = childNodeWithName("MudLayer")!
        scene?.zPosition = 3
        truckLayer.zPosition = 1
        mudLayer.zPosition = 2

        truckLayer.addChild(truck)
        dropMudOverTruck(15, target: truck, duration: 2.0)

        hose = SKEmitterNode(fileNamed: "Water")!
        hose.targetNode = self
        addChild(hose)
        hose.particleBirthRate = 0.0
        physicsWorld.contactDelegate = self

    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        guard let location = touches.first?.locationInNode(self) else {
            return
        }

        hose.particleBirthRate = 150
        hose.position = location

        nodeAtPoint(location).touchesBegan(touches, withEvent: event)

    }

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let location = touches.first?.locationInNode(self)
        hose.position = location!

        nodeAtPoint(location!).touchesMoved(touches, withEvent: event)
    }

    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        hose.particleBirthRate = 0.0
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

// MARK: - MudBucket Methods
extension GameScene {
    func dropMudOverTruck(count: Int, target: TruckNode, duration: NSTimeInterval) {
        let minX = Int(-0.5 * target.size.width)
        let maxX = Int(0.5 * target.size.width)
        let t = duration / Double(count)
        let rangeX = minX ... maxX
        print(rangeX)

        for i in 1...count {
            runAction(SKAction.waitForDuration(Double(i) * t), completion: {
                let mudDrop = MudNode.init(atlas: self.textures)
                self.mudLayer.addChild(mudDrop)
                mudDrop.position.x = CGFloat(self.randomNumber(rangeX))
                print(mudDrop.position.x)
            })
        }

    }

    func randomNumber(from: Range<Int>) -> Int {
        return from.startIndex + Int(arc4random_uniform(UInt32(from.endIndex - from.startIndex)))
    }
}