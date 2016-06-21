//
//  Button.swift
//  MuddyTrucks
//
//  Created by Ben Murphy on 6/21/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import SpriteKit

protocol Button {
    var scene: SKScene? {get}
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?)
}


extension SKShapeNode: Button {
    override public func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let newScene = GameScene(fileNamed: "GameScene")
        scene?.view?.presentScene(newScene)
    }

    
}