//
//  Deck.swift
//  CardGameV2
//
//  Created by Panayiotis Stylianou on 26/09/2016.
//  Copyright © 2016 Brian Broom. All rights reserved.
//

import SpriteKit

class Deck : NSObject {
    
    var player: Player?
    var cards: [Card] = []
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(player: Player, cards: [Card])
    {
        super.init()
        self.player = player
        self.cards = cards
        
    }
}
