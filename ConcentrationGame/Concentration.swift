//
//  Concentration.swift
//  ConcentrationGame
//
//  Created by Piotr Prokopowicz on 06/01/2018.
//  Copyright © 2018 Piotr Prokopowicz. All rights reserved.
//

import Foundation

struct Concentration {
    
    var isWon: Bool {
        get {
            for index in cards.indices {
                if !cards[index].isMatched {
                    return false
                }
            }
            return true 
        }
    }
    var cards = [Card]()
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    } else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    mutating func choseCard(at index: Int) {
        if !cards[index].isMatched {
            if let matchIndex = indexOfTheOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[index].isMatched = true
                    cards[matchIndex].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    mutating func shuffle() {
        var tmp = [Card]()
        let count = cards.count
        for _ in 1...count {
            tmp += [cards.remove(at: cards.count.random())]
        }
        cards = tmp
    }
    
    init(numberOfPairs: Int) {
        for _ in 1...numberOfPairs {
            let card = Card()
            cards += [card, card]
        }
    }
}

extension Int {
    func random() -> Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
