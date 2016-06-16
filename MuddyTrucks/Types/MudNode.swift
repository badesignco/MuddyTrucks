//
//  MudNode.swift
//  MuddyTrucks
//
//  Created by Ben Murphy on 6/16/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import SpriteKit

class MudNode: SKShapeNode, Contactable {

    let contactType = ContactType.Mud

    init(size: CGFloat) {
        super.init()
        zPosition = 1000
        let diameter = size * 2
        self.path = CGPathCreateWithEllipseInRect(CGRect(origin: CGPointZero, size: CGSize(width: diameter, height: diameter)), nil)
        fillColor = UIColor.brownColor()
        strokeColor = UIColor.blackColor()

        physicsBody = SKPhysicsBody.init(circleOfRadius: size)
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = false
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = 1

    

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func contactDidBegin(node: Contactable) {
        print("I hit a truck!")
//        physicsBody?.linearDamping = 1.0
        physicsBody?.affectedByGravity = false
        physicsBody?.velocity = CGVector(dx: 0.0, dy: 50.0)
    }
    func contactDidEnd(node: Contactable) {
        print("Off that truck!")
    }

}


