//
//  ViewController.swift
//  ConcentrationGame
//
//  Created by Виталий Вяжевич on 12/30/20.
//

import UIKit

class ViewController: UIViewController {
    
// lazy означает что переменная game будет инициализирована только тогда, когда будет обращение к ней
    private lazy var game = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
    
    // вычисляемое свойство
    var numberOfPairsOfCards: Int {
        return (buttonCollection.count + 1) / 2
    }

    private(set) var touches = 0 {
        didSet{
            touchLabel.text = "Touches: \(touches)"
        }
    }
    
    private var emojiCollection = ["🦍", "🦏", "🦧", "🐋", "🦩", "🐓", "🦌", "🐊", "🐫", "🐘", "🦒", "🦘"]
    
    private var emojiDictinary = [Int:String]() // словарь карточек
    
    private func emojiIdentifier(for card: Card) -> String {
        if emojiDictinary[card.indentifier] == nil {
            // let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            // emojiDictinary[card.indentifier] = emojiCollection.remove(at: randomIndex)
            emojiDictinary[card.indentifier] = emojiCollection.remove(at: emojiCollection.count.arc4randomExtention)
        }
        return emojiDictinary[card.indentifier] ?? "?"

//      аналогично коду ниже:
//      if emojiDictinary[card.indentifier] != nil {
//          return emojiDictinary[card.indentifier]!
//      } else {
//          return "?"
//      }

    }
    
    private func updateViewFromModel() {
    // функция обновления вида
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 0) : #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
            }
            
        }
    }

    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet private weak var touchLabel: UILabel!
    @IBAction private func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.chooseCard(at: buttonIndex)
            updateViewFromModel()
        }
    }
    
}

// позволяет расширять другие классы, добавлять переменные, функции
// расширяем класс Int для генерации случайного числа
extension Int {
    var arc4randomExtention: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
        
    }
}
