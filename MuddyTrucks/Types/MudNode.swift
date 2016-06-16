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
    var isOverlappingMud = false
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
        if isOverlappingMud ==ç true {
            physicsBody?.velocity.dy *= 0.75
        }
    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        print("Touched")
        isStuckOnTruck = false
        physicsBody?.affectedByGravity = true
    }

}


