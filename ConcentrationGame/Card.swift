//
//  Card.swift
//  ConcentrationGame
//
//  Created by Виталий Вяжевич on 12/30/20.
//

import Foundation

struct Card {
    // структура импользуется вместо класса для создания одинаковых пар-копий карточек
    var isFaceUp = false
    var isMatched = false
    var indentifier: Int
    
    // статическое поле или метод общий для всех объектов
    private static var indentifierNumber = 0
    private static func indentifierGenerator() -> Int {
        indentifierNumber += 1
        return indentifierNumber
    }
    
    init() {
        self.indentifier = Card.indentifierGenerator()
    }
}

