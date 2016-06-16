//
//  MudNode.swift
//  MuddyTrucks
//
//  Created by Ben Murphy on 6/16/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import SpriteKit

class MudNode: SKShapeNode {

    init(size: CGFloat) {
        super.init()
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



}


