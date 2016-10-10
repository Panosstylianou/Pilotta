/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SpriteKit


class GameScene: SKScene {
    
    var cards: [Card] = []
    var players: [Player] = []

    var team1: Team?
    var team2: Team?
    var frameSize: CGSize?
    
    enum CardLevel :CGFloat {
        case board = 10
        case moving = 100
        case enlarged = 200
    }

    override func didMove(to view: SKView) {
        frameSize = self.frame.size
        initializeCards()
        initializePlayers()
        
        cards.shuffle()
        
        
            
        
        
//        dealCards()
        
        let bg = SKSpriteNode(imageNamed: "background")
        bg.size = self.frame.size
        bg.anchorPoint = CGPoint.zero
        bg.position = CGPoint.zero
        addChild(bg)


        for player in players
        {
            if !player.isSelf
            {
                let playerNode = Player(isSelf: false, seat: player.seat,frame: frameSize!)
    //            playerNode.position = CGPoint(x: 100, y: 200)
    //            addChild(cardNode)
            }
        }
        
        for card in cards{
    //        let cardNode = Card(cardType: card.cardType, cardNumber: card.cardNumber)
            card.position = CGPoint(x: frameSize!.width/2, y: frameSize!.height/2)
            addChild(card)
            card.flip()

            
        }
        
        
//        showCards()
//        sortCards()
    }
    
    

//    
//    let wolf = Card(cardType: .Clubs, cardNumber: .Seven)
//    wolf.position = CGPointMake(100,200)
//    addChild(wolf)
//    
//    let bear = Card(cardType: .Diamonds, cardNumber: .Ace)
//    bear.position = CGPointMake(300, 200)
//    addChild(bear)
    
    

    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches {
                let location = touch.location(in: self)           // 1
                if let card = atPoint(location) as? Card {      // 2
                    card.position = location
                }
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches
        {
    
            let location = touch.location(in: self)
            if let card = atPoint(location) as? Card
            {
                dealCards()
                if touch.tapCount == 1
                {
                    card.xScale = 1.5
                    card.yScale = 1.5
                    card.zPosition = 1
                }
                if touch.tapCount == 2
                {
                    card.flip()
                }
                if touch.tapCount == 3
                {
                    showCards()
                }
            }
        }
    }

    func initializeCards()
    {
        var cards: [Card] = []
//        
//        let shadow = SKSpriteNode(imageNamed: "7_of_spades")
//        shadow.blendMode = SKBlendMode.alpha
//        shadow.colorBlendFactor = 1
//        shadow.color = SKColor.black
//        shadow.alpha = .25
        
        for type in CardType.allValues
        {
            for number in CardNumber.allValues
            {
                
                let card = Card(cardType: type, cardNumber: number)
                
                let rect = card.texture?.textureRect()
                var myTransform = CGAffineTransform.identity
                var transform = CGAffineTransform(scaleX: card.size.width, y: card.size.height)

                var path = withUnsafePointer(to: &myTransform) { (pointer: UnsafePointer<CGAffineTransform>) -> (CGPath) in
                    return CGPath(rect: rect!, transform: &transform)
                }
//                let path = CGPath(rect: rect!, transform: transform)
                let shape = SKShapeNode(path: path)
                shape.lineWidth = 2.0
                shape.glowWidth = 0.5
                shape.fillColor = UIColor.black
                card.addChild(shape)
                cards.append(Card(cardType: type, cardNumber: number))
            }
        }
        self.cards = cards
    }
    
    func initializePlayers()
    {
        var players: [Player] = []
        
        players.append(Player(isSelf: true, seat: 1,frame: frameSize!))
        players.append(Player(isSelf: false, seat: 2,frame: frameSize!))
        players.append(Player(isSelf: false, seat: 3,frame: frameSize!))
        players.append(Player(isSelf: false, seat: 4,frame: frameSize!))
        
    
        
        self.players = players
        
        initializeTeams()
        
    }
    
    func initializeTeams()
    {
        for i in 0...3
        {
            if (i<3) { players[i].nextPlayer = players[i+1] }
            else {players[i].nextPlayer = players[0]
        }
            
        for i in 0...3
        {
            if (i>0) { players[i].previousPlayer = players[i-1] }
            else {players[i].previousPlayer = players[3]
            }
        }
        
        players[0].playsFirst = true
        
        players[0].nextPlayer = players[1]
        team1 = Team(p1: players[0], p2: players[2])
        
        team2 = Team(p1: players[1], p2: players[3])

        }
    }
    
    func setLocation(player: Player) -> Player
    {
        var newPlayer = player
        var location: CGPoint?
        switch player.seat {
        case 1:
            location =  CGPoint(x: (frameSize!.width-50), y: frameSize!.height/2)
        case 2:
            location =  CGPoint(x: frameSize!.width/2, y: 50)
        case 3:
            location =  CGPoint(x: 50, y: frameSize!.height/2)
        case 4:
            location = CGPoint(x: frameSize!.width/2, y: frameSize!.height-50)
        default:
            location =  CGPoint(x: (frameSize!.width-50), y: frameSize!.height/2)
        }
        
        newPlayer.location = location
        return newPlayer
    }
    
    func dealCards()
    {
        var dealingPlayer = team1!.player1!
        if (team1?.player1?.playsFirst)!
        {
            
            for _ in 1...4
            {
                cardsToPlayer(player: dealingPlayer, numOfCards: 3)
                dealingPlayer = dealingPlayer.nextPlayer!
            }
            for _ in 1...4
            {
                cardsToPlayer(player: dealingPlayer, numOfCards: 2)
                dealingPlayer = dealingPlayer.nextPlayer!
            }
            for _ in 1...4
            {
                cardsToPlayer(player: dealingPlayer, numOfCards: 3)
                dealingPlayer = dealingPlayer.nextPlayer!
            }
        }
        sortCards()
    }
    
    func cardsToPlayer(player: Player, numOfCards: Int)
    {
        let location = player.location
        let cardsLocation = CGPoint(x: frameSize!.width/2, y: frameSize!.height/2)
        let action = SKAction.move(to: location!, duration: 2.0)
        var wait = SKAction.wait(forDuration: 2.0)
        
        for _ in 1...numOfCards
        {
            if let card = cards.last
            {
                card.run(action)

                player.cards.append(card)
                cards.popLast()
            }
            
        }
        
        
//        for card in cards.reversed()
//        {
//            card.run(action)
//            
//        }

        
    }
    
    func showCards() {
        for player in players
        {
            var count: CGFloat = -3
            var count2: CGFloat = 0
            var count4: CGFloat = -8

            switch player.seat {
            case 1,3:
                for card in player.cards
                {
                    card.position = CGPoint(x: player.location!.x + count*card.size.width/4*3, y: player.location!.y)
                    count += 1
                    card.flip()
                }
            case 2:
                for card in player.cards
                {
                    card.position = CGPoint(x: player.location!.x + count2*card.size.width/4*3, y: player.location!.y)
                    count2 += 1
                    card.flip()
                }
            case 4:
                for card in player.cards
                {
                    card.position = CGPoint(x: player.location!.x + count4*card.size.width/4*3, y: player.location!.y)
                    count4 += 1
                    card.flip()
                }
            default:
                return
            }

        }
    }
    
    func sortCards()
    {
        for player in players
        {
            var clubs:[Card] = []
            var diamonds:[Card] = []
            var hearts:[Card] = []
            var spades:[Card] = []
            
            var hand: [[Card]] = []
            var sortedHand: [Card] = []
            
            for card in player.cards
            {
                switch card.cardType{
                case .clubs:
                    clubs.append(card)
                case .diamonds:
                    diamonds.append(card)
                case .hearts:
                    hearts.append(card)
                case .spades:
                    spades.append(card)
                }
            }
            
            hand.append(clubs)
            hand.append(diamonds)
            hand.append(hearts)
            hand.append(spades)
    
            for type in hand
            {
                let newType = type.sorted { $0.strength < $1.strength }
                sortedHand += newType
            }
            player.cards = sortedHand
        }
    }
    

}

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<count-1
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}






