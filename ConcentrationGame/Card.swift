//
//  Card.swift
//  ConcentrationGame
//
//  Created by Piotr Prokopowicz on 06/01/2018.
//  Copyright © 2018 Piotr Prokopowicz. All rights reserved.
//

import Foundation

struct Card: Hashable {
    var hashValue: Int { return id }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    private let id: Int
    var isFaceUp = false
    var isMatched = false
    private static var idFactory = 0
    
    init() {
        id = Card.getUniqueId()
    }
    
    private static func getUniqueId() -> Int {
        idFactory += 1
        return idFactory
    }
}

