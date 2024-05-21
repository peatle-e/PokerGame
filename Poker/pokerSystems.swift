//
//  pokerSystems.swift
//  Poker
//
//  Created by 이재영 on 2024/05/20.
//
import Foundation

struct SevenPokerTable: PokerGameTable {
    
    var ante: Int
    
    var deck: TrumpCardDeck = TrumpCardDeck()
    
    var pod: Pod = Pod()
    
    var players: [Player :SevenPokerHand] = [:]
    
    var participating: [Player] {
        Array<Player>(players.keys).reduce([], { $0 + ($1.isPlaying ? [$1] : []) })
    }
    
    var round: Round?
    
    mutating func addPlayers(_ players: Player...) {
        for player in players {
            self.players[player] = SevenPokerHand()
        }
    }
    
    mutating func setAnte(_ money: Int) { self.ante = money }
    
    mutating func opening() {
        guard self.round == nil else { return }
        
        deck.refill()
        deck.shuffle()
        round = .opening
        return
    }
    
    mutating func dealing() {
        guard let round = round else { return }
        
        let numberOfDealingCards: Int = round == Round.opening ? 4 : 1
        
        participating.forEach { self.players[$0]?.getCard(deck.drawing(numberOfDealingCards)) }
    }
    
    mutating func clear() {
        for player in players {
            players[player.key]?.returnCard()
        }
        self.round = nil
    }
    
    func printPlayersCard() {
        players.forEach {
            print("플레이어: " + "\($0.key.name)" + "/  패: " + "\($0.value.cards.sorted(by: {$0.rank.rawValue < $1.rank.rawValue }) .map { $0.convert() } )" )
        }
    }
}

protocol PokerGameTable {
    
    var ante: Int {get}
    
    var deck: TrumpCardDeck {get}
    
    var pod: Pod {get}
    
    var players: [Player: SevenPokerHand] {get}
    
    var participating: [Player] {get}
    
    var round: Round? {get}
    
    
    mutating func addPlayers(_ players: Player...)
    
    mutating func setAnte(_ money: Int)
    
    mutating func opening()
    
    mutating func dealing()
    
    mutating func clear()
}

enum PokerRanking: Int, Comparable {
    case highCard       = 1
    case onePair        = 2
    case twoPair        = 3
    case threeOfKind    = 4
    case straight       = 5
    case flush          = 6
    case fullHouse      = 7
    case fourOfKind     = 8
    case straightFlush  = 9
    case royalStraightFlush     = 10
    
    func convert() -> String {
        switch self {
        case .highCard              : return  "하이 카드"
        case .onePair               : return  "원 페어"
        case .twoPair               : return  "투 페어"
        case .threeOfKind           : return  "트리플"
        case .straight              : return  "스트레이트"
        case .flush                 : return  "플러시"
        case .fullHouse             : return  "풀 하우스"
        case .fourOfKind            : return  "포카드"
        case .straightFlush         : return  "스트레이트 플러시"
        case .royalStraightFlush    : return  "로얄 스트레이트 플러시"
        }
    }
    
    static func < (lhs: PokerRanking, rhs: PokerRanking) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    

}

struct Pod {
    
    var main: Int = 0
    
    var side: Int = 0
    
    mutating func addMain(_ money: Int) { self.main += money }
    
    mutating func addSide(_ money: Int) { self.side += money }
    
    mutating func returnMain(_ money: Int) -> Int {
        defer { self.main = 0 }
        return self.main
    }
    
    mutating func returnSide(_ money: Int) -> Int {
        defer { self.side = 0 }
        return self.side
    }
}

struct SevenPokerHand: PokerHand {
    
    var cards: [TrumpCard] = []
    
    mutating func getCard(_ gettedCards: [TrumpCard]) { self.cards += gettedCards }
    
    mutating func returnCard() { self.cards = [] }
    
    static func rank() -> (handRanking: PokerRanking, kicker: TrumpCard) {
        (PokerRanking.highCard ,TrumpCard(suit: .clover, rank: .ace))
    }
    

}

protocol PokerHand: Hashable {
    var cards: [TrumpCard] {get}
    
    mutating func getCard(_ gettedCards: [TrumpCard])
    
    mutating func returnCard()
    
    static func rank() -> (handRanking: PokerRanking, kicker: TrumpCard)
}

enum Round {
    case opening
    case second
    case third
    case fourth
}
