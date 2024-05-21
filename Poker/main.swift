//
//  main.swift
//  Poker
//
//  Created by 이재영 on 2024/05/20.
//
import Foundation

let player1 = Player(name: "player1", money: 5000, isPlaying: true)
let player2 = Player(name: "player2", money: 5000, isPlaying: true)
let player3 = Player(name: "player3", money: 5000, isPlaying: true)
let player4 = Player(name: "player4", money: 5000, isPlaying: true)

var sevenPorkerTable = SevenPokerTable(ante: 500)

sevenPorkerTable.addPlayers(player1, player2, player3, player4)

sevenPorkerTable.opening()

sevenPorkerTable.dealing()

sevenPorkerTable.printPlayersCard()

