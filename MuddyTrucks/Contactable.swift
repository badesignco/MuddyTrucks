//
//  Contactable.swift
//  MuddyTrucks
//
//  Created by Ben Murphy on 6/16/16.
//  Copyright © 2016 Constellation Software. All rights reserved.
//

import SpriteKit

enum ContactType {
    case Mud
    case Truck
}

protocol Contactable {
    var contactType: ContactType { get }
    func contactDidBegin(node: Contactable)
    func contactDidEnd(node: Contactable)
}