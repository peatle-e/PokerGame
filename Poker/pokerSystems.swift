//
//  pokerSystems.swift
//  Poker
//
//  Created by 이재영 on 2024/05/20.
//
import Foundation

private protocol PokerGameTable {
    
    var deck: TrumpCardDeck {get}
    
    var ante: Int {get}
    
    var pod: Pod {get}
    
    var players: [Player] {get}
    
    var participating: [Player] {get}
    
    var round: Round? {get}
    
    
    mutating func addPlayers(_ players: Player...)
    
    mutating func setAnte(_ money: Int)
    
    mutating func opening()
    
    mutating func dealing()
    
    mutating func clear()
}


struct SevenPokerTable: PokerGameTable {
    
    fileprivate var deck: TrumpCardDeck = TrumpCardDeck()
    
    var ante: Int
    
    var pod: Pod = Pod()
    
    var players: [Player] = []
    
    var participating: [Player] {
        Array<Player>(self.players.filter { $0.isPlaying })
    }
    
    var round: Round?
    
    
    init(ante: Int) { self.ante = ante }
    
    
    mutating func addPlayers(_ add: Player...) {
        add.forEach { self.players.append($0) }
    }
    
    mutating func setAnte(_ money: Int) {
        self.ante = money }
    
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
        
        participating.forEach {
            let drawingCard = deck.drawing(numberOfDealingCards)
            $0.hand.getCard(drawingCard)
        }
    }
    
    mutating func clear() {
        players.forEach { $0.hand.returnCard() }
        self.round = nil
    }
    
    func printPlayersCard() {
        players.sorted { $0.name <  $1.name }
               .forEach { print("플레이어: " , $0.name , ",  패: " , $0.hand ) }
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





enum Round {
    case opening
    case second
    case third
    case fourth
}

enum PokerRanking: Int, Comparable {
    case highCard               = 1
    case onePair                = 2
    case twoPair                = 3
    case threeOfKind            = 4
    case straight               = 5
    case flush                  = 6
    case fullHouse              = 7
    case fourOfKind             = 8
    case straightFlush          = 9
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

