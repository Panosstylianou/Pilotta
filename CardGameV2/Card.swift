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

enum CardType :Int {
    case spades,
    hearts,
    diamonds,
    clubs
    
    static let allValues = [spades, hearts, diamonds, clubs]
}

enum CardNumber: Int {
    case seven,
    eight,
    nine,
    ten,
    jack,
    queen,
    king,
    ace
    
    static let allValues = [seven, eight, nine, ten, jack, queen, king, ace]
}

class Card : SKSpriteNode {
    let cardType :CardType
    let cardNumber: CardNumber
    let frontTexture :SKTexture
    let backTexture :SKTexture
    var strength: Int = 0
    
    var faceUp = true
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init(cardType: CardType, cardNumber: CardNumber) {
        self.cardType = cardType
        self.cardNumber = cardNumber
        backTexture = SKTexture(imageNamed: "card_back")
        
        switch cardType {
        case .spades:
            
            switch cardNumber {
            case .seven:
                frontTexture = SKTexture(imageNamed: "7_of_spades")
            case .eight:
                frontTexture = SKTexture(imageNamed: "8_of_spades")
            case .nine:
                frontTexture = SKTexture(imageNamed: "9_of_spades")
            case .ten:
                frontTexture = SKTexture(imageNamed: "10_of_spades")
            case .jack:
                frontTexture = SKTexture(imageNamed: "jack_of_spades")
            case .queen:
                frontTexture = SKTexture(imageNamed: "queen_of_spades")
            case .king:
                frontTexture = SKTexture(imageNamed: "king_of_spades")
            case .ace:
                frontTexture = SKTexture(imageNamed: "ace_of_spades")
            }
            
            
        case .hearts:
            switch cardNumber {
            case .seven:
                frontTexture = SKTexture(imageNamed: "7_of_hearts")
            case .eight:
                frontTexture = SKTexture(imageNamed: "8_of_hearts")
            case .nine:
                frontTexture = SKTexture(imageNamed: "9_of_hearts")
            case .ten:
                frontTexture = SKTexture(imageNamed: "10_of_hearts")
            case .jack:
                frontTexture = SKTexture(imageNamed: "jack_of_hearts")
            case .queen:
                frontTexture = SKTexture(imageNamed: "queen_of_hearts")
            case .king:
                frontTexture = SKTexture(imageNamed: "king_of_hearts")
            case .ace:
                frontTexture = SKTexture(imageNamed: "ace_of_hearts")
            }
        
        
        
        case .diamonds:
            switch cardNumber {
            case .seven:
                frontTexture = SKTexture(imageNamed: "7_of_diamonds")
            case .eight:
                frontTexture = SKTexture(imageNamed: "8_of_diamonds")
            case .nine:
                frontTexture = SKTexture(imageNamed: "9_of_diamonds")
            case .ten:
                frontTexture = SKTexture(imageNamed: "10_of_diamonds")
            case .jack:
                frontTexture = SKTexture(imageNamed: "jack_of_diamonds")
            case .queen:
                frontTexture = SKTexture(imageNamed: "queen_of_diamonds")
            case .king:
                frontTexture = SKTexture(imageNamed: "king_of_diamonds")
            case .ace:
                frontTexture = SKTexture(imageNamed: "ace_of_diamonds")
            }
        
        case .clubs:
            switch cardNumber {
            case .seven:
                frontTexture = SKTexture(imageNamed: "7_of_clubs")
            case .eight:
                frontTexture = SKTexture(imageNamed: "8_of_clubs")
            case .nine:
                frontTexture = SKTexture(imageNamed: "9_of_clubs")
            case .ten:
                frontTexture = SKTexture(imageNamed: "10_of_clubs")
            case .jack:
                frontTexture = SKTexture(imageNamed: "jack_of_clubs")
            case .queen:
                frontTexture = SKTexture(imageNamed: "queen_of_clubs")
            case .king:
                frontTexture = SKTexture(imageNamed: "king_of_clubs")
            case .ace:
                frontTexture = SKTexture(imageNamed: "ace_of_clubs")
            }
        }

        switch cardNumber {
        case .seven:
            strength = 1
        case .eight:
            strength = 2
        case .nine:
            strength = 3
        case .jack:
            strength = 4
        case .queen:
            strength = 5
        case .king:
            strength = 6
        case .ten:
            strength = 7
        case .ace:
            strength = 8
        }
        
        super.init(texture: frontTexture, color: UIColor.clear, size: CGSize(width: 50.0, height: 72.6))
    }
    
    func flip() {
        if faceUp {
            self.texture = backTexture
        } else {
            self.texture = frontTexture
        }
        faceUp = !faceUp
    }
}
