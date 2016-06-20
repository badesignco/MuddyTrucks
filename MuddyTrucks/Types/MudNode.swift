//
//  MudNode.swift
//  MuddyTrucks
//
//  Created by Ben Murphy on 6/16/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import SpriteKit

class MudNode: SKSpriteNode, Contactable {

    var isStuckOnTruck = false
    var isOverlappingMud = false
    let contactType = ContactType.Mud

    init() {
        let texture = SKTexture(imageNamed: "mudDrop")
        super.init(texture: texture, color: UIColor.clearColor(), size: texture.size())
        zPosition = 1000
        physicsBody = SKPhysicsBody.init(texture: texture, size: texture.size())
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = false
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = 1

        userInteractionEnabled = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func contactDidBegin(node: Contactable) {
        switch node {
        case is MudNode:
            isOverlappingMud = true
        case is TruckNode:
            physicsBody?.affectedByGravity = false
            isStuckOnTruck = true
        default:
            return
        }

        
    }
    func contactDidEnd(node: Contactable) {
        switch node {
        case is MudNode:
            isOverlappingMud = false
        case is TruckNode:
            isStuckOnTruck = false
            physicsBody?.affectedByGravity = true
        default:
            return
        }
    }

    func applyFriction() {
        if isStuckOnTruck == true && isOverlappingMud == false {
            physicsBody?.velocity.dy *= 0.50 }
        if isOverlappingMud == true {
            physicsBody?.velocity.dy *= 0.75
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Touched")
        isStuckOnTruck = false
        physicsBody?.affectedByGravity = true
    }

}


