//
//  GameModel.swift
//  ConcentrationGame
//
//  Created by Виталий Вяжевич on 12/30/20.
//

import Foundation

class ConcentrationGame {
    private(set) var cards = [Card]() // массив из структур Cards
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        // смотрим на все карты и проверяем есть ли одна едиственная преревернутая карточка
        // если нашли, то возвращаем индекс, в противном случае возвращаем nil
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
        // переворачиваем все карты кроме одной карты с индексом newValue
        set {
            for index in cards.indices {
                // присвоение булевого значения
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    func chooseCard(at index: Int) {
        // проверяем не нажали ли мы на совпавшую пару еще раз
        if !cards[index].isMatched {
            // проверяем чтобы была перевернута вверх только одна карточка
            if let matchingIndex = indexOfOneAndOnlyFaceUpCard, matchingIndex != index { // проверка и распаковка опц. типа
                // проверяем совпали ли у перевернутой и нажатой карточки индентификаторы
                if cards[matchingIndex].indentifier == cards[index].indentifier {
                    cards[matchingIndex].isMatched = true // помечаем карточку как совпавшую
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true // помечаем какрточку как перевернутую
                
//                indexOfOneAndOnlyFaceUpCard = nil // обнуляем индекс певеренутой карточки
            } else { // иначе если не перевернуто ни одной, либо перевернуто более одной карточки
//                for flipDown in cards.indices {
//                    cards[flipDown].isFaceUp = false // переворачиваем все карточки лицом вниз
//                }
//                cards[index].isFaceUp = true // оставляем перевернутой вверх только одну нажатую карточку
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        
    }
    
    init(numberOfPairsOfCards: Int) {
        // утверждение для проверки на ошибки
        assert(numberOfPairsOfCards > 0, "ConcentrationGame.init numberOfPairsOfCards:\(numberOfPairsOfCards) must have at least one pair of cards")
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
            // аналогично:
            // cards.append(card)
            // cards.append(card)
        }
        cards.shuffle()
        
    }
}

