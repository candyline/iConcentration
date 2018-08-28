//
//  Concentration.swift
//  iConcentrate
//
//  Created by Frank Su on 2018-08-21.
//  Copyright © 2018 CandylineStudio. All rights reserved.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0
    private var indexOfOneAndOnlyFaceUpCard: Int? {
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
        set (newValue){
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    func chooseCard(at index: Int) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                } else {
                    //wonder if theres a cleaner way to do this
                    if cards[index].flippedBefore {
                        score -= 1
                    }
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
                if cards[index].flippedBefore {
                    score -= 1
                }
            }
        }
        cards[index].flippedBefore = true
    }
    func newGame() {
        for index in cards.indices {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
            cards[index].flippedBefore = false
        }
        indexOfOneAndOnlyFaceUpCard = nil
        flipCount = 0
        score = 0
        cards.removeAll()
    }
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        // TODO: Shuffle the cards
        var shuffledCards = [Card]()
        for _ in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            let randomCardPicked = cards.remove(at: randomIndex)
            shuffledCards += [randomCardPicked]
        }
        cards = shuffledCards
        
    }
}
