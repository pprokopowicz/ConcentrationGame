//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Piotr Prokopowicz on 06/01/2018.
//  Copyright © 2018 Piotr Prokopowicz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    private lazy var game = Concentration(numberOfPairs: cardButtons.count/2)
    private var emojiChoices = ["🧣", "🧤", "❄️", "☃️", "🌨", "🇨🇦", "🎅🏻", "🤶🏻"]
    private var emoji = [Card:String]()
    private var flipCount = 0 { didSet { flipCountLabel.text = "Flips: \(flipCount)" }}
    
    @IBAction func newGame(_ sender: UIButton) {
        flipCount = 0
        game = Concentration(numberOfPairs: cardButtons.count/2)
        game.shuffle()
        updateViewFromModel()
        newGameButton.isEnabled = false
        for index in cardButtons.indices {
            cardButtons[index].isEnabled = true
        }
        emojiChoices = ["🧣", "🧤", "❄️", "☃️", "🌨", "🇨🇦", "🎅🏻", "🤶🏻"]
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.choseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        if game.isWon {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                button.isEnabled = false
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                button.setTitle("", for: .normal)
            }
            newGameButton.isEnabled = true
        } else {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
                } else {
                    button.setTitle("", for: .normal)
                    if card.isMatched {
                        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
                        button.isEnabled = false
                    } else {
                        button.backgroundColor = #colorLiteral(red: 0, green: 0.5898008943, blue: 1, alpha: 1)
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game.shuffle()
    }
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: emojiChoices.count.random())
        }
        return emoji[card] ?? "?"
    }
}

