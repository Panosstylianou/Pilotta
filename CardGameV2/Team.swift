//
//  Team.swift
//  CardGameV2
//
//  Created by Panayiotis Stylianou on 20/09/2016.
//  Copyright © 2016 Brian Broom. All rights reserved.
//

import Foundation

class Team: NSObject
{
    var player1: Player?
    var player2: Player?
    
    init(p1: Player, p2: Player) {
        super.init()

        p1.partner = p2
        player1 = p1
        player1?.team = self

        p2.partner = p1
        player2 = p2
        player2?.team = self

        
        

    }
    
}


