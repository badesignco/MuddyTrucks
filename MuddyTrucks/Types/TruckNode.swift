//
//  TruckNode.swift
//  MuddyTrucks
//
//  Created by Ben Murphy on 6/16/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import SpriteKit

class TruckNode: SKSpriteNode, Contactable {

    let contactType = ContactType.Truck

    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        let texture = SKTexture(imageNamed: "red_dumptruck")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
//        physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        physicsBody = SKPhysicsBody(rectangleOfSize: texture.size())
        physicsBody?.affectedByGravity = false
        physicsBody?.allowsRotation = false
        physicsBody?.collisionBitMask = 0
        physicsBody?.pinned = true
        physicsBody?.contactTestBitMask = 1
        print("Truck ready to get muddy!")

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func contactDidBegin(node: Contactable) {
        print("Mud on me!")
    }

    func contactDidEnd(node: Contactable) {
        print("That mud is gone!")
    }

    
}
