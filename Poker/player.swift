//
//  player.swift
//  Poker
//
//  Created by 이재영 on 2024/05/20.
//

import Foundation

class Player:  CustomStringConvertible {
    
    var hand = SevenPokerHand()
    
    private(set) var money: Int
    
    private(set) var isPlaying: Bool
    
    private(set) var name: String
    
    var description: String { self.name }
    
    init(name: String, money: Int, isPlaying: Bool) {
        self.name = name
        self.money = money
        self.isPlaying = isPlaying
    }
}

private protocol PokerHand: Hashable, CustomStringConvertible {
    
    var cards: [TrumpCard] {get}
    
    mutating func getCard(_ gettedCards: [TrumpCard])
    
    mutating func returnCard()
    
    func handRanking() -> (handRanking: PokerRanking, kicker: TrumpCard)
    
    func checkRank()
}


struct SevenPokerHand: PokerHand {
    
    private(set) var cards: [TrumpCard] = []
    
    var description: String {
        cards.sorted { $0.rank.rawValue < $1.rank.rawValue }
             .map { $0.convert() }
             .joined(separator: ", ")
    }
    
    mutating func getCard(_ gettedCards: [TrumpCard]) { self.cards += gettedCards }
    
    mutating func returnCard() { self.cards = [] }
    
    
    func handRanking() -> (handRanking: PokerRanking, kicker: TrumpCard) {            
        (PokerRanking.highCard ,TrumpCard(suit: .clover, rank: .ace))
    }
    
    func checkRank() {
        print( "랭크:", self.handRanking().handRanking, "/ 키커:" , self.handRanking().kicker, separator: " ")
    }
}
