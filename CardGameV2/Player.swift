//
//  Player.swift
//  CardGameV2
//
//  Created by Panayiotis Stylianou on 14/09/2016.
//  Copyright © 2016 Brian Broom. All rights reserved.
//

import Foundation
import SpriteKit

class Player: NSObject
{
    
    var isSelf = false
    var seat = 0
    var team: Team?
    var nextPlayer: Player?
    var previousPlayer: Player?
    var partner: Player?
    var playsFirst = false
    var frame: CGSize?
    var location: CGPoint?
    var cards: [Card] = []
    var deck: Deck?

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    
    init(isSelf: Bool, seat: Int, frame: CGSize)
    {
        super.init()
        self.isSelf = isSelf
        self.seat = seat
        self.frame = frame
        self.setLocation()

    }
    
    func setLocation()
    {
        switch seat {
        case 4:
            location = CGPoint(x: frame!.width-50, y: frame!.height/2)
        case 1:
            location = CGPoint(x: frame!.width/2, y: 50)
        case 2:
            location = CGPoint(x: 50, y: frame!.height/2)
        case 3:
            location = CGPoint(x: frame!.width/2, y: frame!.height-50)
        default:
            return

        }
    }

}
