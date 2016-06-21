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

    init(atlas: SKTextureAtlas) {
        let r = arc4random_uniform(UInt32(atlas.textureNames.count))
        let textureName = atlas.textureNames[Int(r)]
        let texture = atlas.textureNamed(textureName)

        super.init(texture: texture, color: UIColor.brownColor(), size: texture.size())
        //physicsBody = SKPhysicsBody.init(texture: texture, size: texture.size())
        colorBlendFactor = 1.0
        alpha = 0.9
        blendMode = .Alpha
        physicsBody = SKPhysicsBody.init(rectangleOfSize: texture.size())
        physicsBody?.affectedByGravity = true
        physicsBody?.allowsRotation = false
        physicsBody?.collisionBitMask = 0
        physicsBody?.contactTestBitMask = 1

        setScale(UIScreen.mainScreen().scale)
        //userInteractionEnabled = true

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

    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        isStuckOnTruck = false
        physicsBody?.affectedByGravity = true
    }

}


