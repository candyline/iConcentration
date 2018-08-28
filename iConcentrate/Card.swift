//
//  Card.swift
//  iConcentrate
//
//  Created by Frank Su on 2018-08-21.
//  Copyright © 2018 CandylineStudio. All rights reserved.
//

import Foundation

struct Card {
    var isFaceUp = false
    var isMatched = false
    var flippedBefore = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init(){
        self.identifier = Card.getUniqueIdentifier()
    }
}
