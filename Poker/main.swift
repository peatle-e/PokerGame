//
//  main.swift
//  Poker
//
//  Created by 이재영 on 2024/05/20.
//
import Foundation
let lee = Player(name: "lee", money: 5000, isPlaying: true)
let kim = Player(name: "kim", money: 5000, isPlaying: true)
let park = Player(name: "park", money: 5000, isPlaying: true)
let kang = Player(name: "kang", money: 5000, isPlaying: true)

var casinoSevenPokerTable1 = SevenPokerTable(ante: 500)

casinoSevenPokerTable1.addPlayers(lee, kim, park, kang)

casinoSevenPokerTable1.opening()

casinoSevenPokerTable1.dealing()

casinoSevenPokerTable1.printPlayersCard()


