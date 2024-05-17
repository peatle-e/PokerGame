//
//  main.swift
//  Poker
//
//  Created by 이재영 on 2024/05/16.
//

import Foundation

protocol CardGameTable {
    var game: CardGame {get}
        
    var bettingSystem: BettingSystem {get}
    
    var players: [Player] {get}
    
    func gameStart(seed: Int)
    
    func betting(player: Player,_ betting: () -> Void)
}

protocol CardGame {
    var playingCard: [Card] {get}
    
    var cardCount: Int {get}
    
    func judge(hand: [Card]) -> Ranking
}

protocol BettingSystem {
    var pot: Int {get}
    var sidePot: Int {get}
    var isDone: Bool {get}
    
    func call()
    func harp()
    func check()
    func die()
}

protocol Player {
    var money: Int {get}
    var hand: [Card] {get}
    var isPlaying: Bool { get }
}

typealias Card = (number: NumberOfCard, mark: Mark)

enum Mark: String, Hashable, Comparable {
    static func < (lhs: Mark, rhs: Mark) -> Bool {
        guard lhs != rhs else { return false }
        switch (lhs, rhs) {
        case (.spade, _):
            return false
        case (_, .spade):
            return true
        case (.diamond, _):
            return false
        case (_, .diamond):
            return true
        case (.heart, _):
            return false
        case (_, .heart):
            return true
        case (.clover, .clover):
            return false
        }
    }
    
    static func > (lhs: Mark, rhs: Mark) -> Bool {
        guard lhs != rhs else { return false }
        return !(lhs < rhs)
    }
    
    static func <= (lhs: Mark, rhs: Mark) -> Bool {
        guard lhs != rhs else { return true }
        return (lhs < rhs)
    }
    
    static func >= (lhs: Mark, rhs: Mark) -> Bool {
        guard lhs != rhs else { return true }
        return (lhs > rhs)
    }
    
    case spade = "♤"
    case diamond = "♦︎"
    case heart = "♥︎"
    case clover = "♧"
}

enum NumberOfCard: Int, Comparable, Hashable {
    static func < (lhs: NumberOfCard, rhs: NumberOfCard) -> Bool {
        return lhs.rawValue < rhs.rawValue
    }
    
    static func <= (lhs: NumberOfCard, rhs: NumberOfCard) -> Bool {
        return lhs.rawValue <= rhs.rawValue
    }
    
    static func > (lhs: NumberOfCard, rhs: NumberOfCard) -> Bool {
        return lhs.rawValue > rhs.rawValue
    }
    
    static func >= (lhs: NumberOfCard, rhs: NumberOfCard) -> Bool {
        return lhs.rawValue >= rhs.rawValue
    }
        
    case ace = 14
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case j = 11
    case q = 12
    case k = 13
}

enum Ranking {
    case royalFlush
    case straightFlush
    case fourOfKind
    case fullHouse
    case flush
    case straight
    case threeOfKind
    case twoPair
    case onePair
    case highCard
}
