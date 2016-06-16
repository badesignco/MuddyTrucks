//
//  MudNode.swift
//  MuddyTrucks
//
//  Created by Ben Murphy on 6/16/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import SpriteKit

class MudNode: SKShapeNode, Contactable {

    var isStuckOnTruck = false
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

        userInteractionEnabled = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func contactDidBegin(node: Contactable) {
        print("I hit a truck!")
//        physicsBody?.linearDamping = 1.0
        physicsBody?.affectedByGravity = false
        isStuckOnTruck = true
        
    }
    func contactDidEnd(node: Contactable) {
        print("Off that truck!")
        isStuckOnTruck = false
    }

    func applyFriction() {
        if isStuckOnTruck == true {
            physicsBody?.velocity.dy *= 0.66        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Touched")
        isStuckOnTruck = false
        physicsBody?.affectedByGravity = true
    }

}


