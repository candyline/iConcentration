//
//  ViewController.swift
//  iConcentrate
//
//  Created by Frank Su on 2018-08-19.
//  Copyright © 2018 CandylineStudio. All rights reserved.
//  Everytime you're copying and pasting code.. you're doin it wrong.

import UIKit

class ViewController: UIViewController
{
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards )
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction func newGameButton(_ sender: UIButton) {
        game.newGame()
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards )
        updateViewFromModel()
        emojiChoices = pickRandomEmojiTheme()
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender){
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
        
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
   
    private func pickRandomEmojiTheme() -> [String] {
        var themeArray = [[String]]()
        themeArray.append(["⚽️","🏀","🏈","🎾","🎱","🥊","🥋","🏓"])
        themeArray.append(["😇","😤","😘","🤪","😉","☺️","😍","😏"])
        themeArray.append(["🍖","🥩","🍟","🍙","🍔","🍞","🍱","🌭"])
        themeArray.append(["🚗","🚙","🚑","🚒","🚎","🏎","✈️","🚀"])
        themeArray.append(["❤️","💚","💜","🖤","💕","💝","❣️","💘"])
        themeArray.append(["🎃","👻","👹","😈","🕷","🦇","👽","☠️"])
        return themeArray[themeArray.count.arc4random]
    }
    //cannot use instance member within property initializer. Need lazy
    lazy private var emojiChoices = pickRandomEmojiTheme()
    private var emoji = [Int:String]()
    private func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emoji[card.identifier] ?? "?"
    }
}
extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}
