//
//  player.swift
//  Poker
//
//  Created by 이재영 on 2024/05/20.
//

import Foundation

class Player: Hashable {
    private var money: Int
    var isPlaying: Bool
    var name: String
    
    //    func call() {
    //        <#code#>
    //    }
    //
    //    func harp() {
    //        <#code#>
    //    }
    //
    //    func check() {
    //        <#code#>
    //    }
    //
    //    func die() {
    //        <#code#>
    //    }
    
    func ante(_ bet: Int) {
        guard self.money > bet else { return isPlaying = false }
        money -= bet
        return isPlaying = true
    }
    
    init(name: String, money: Int, isPlaying: Bool) {
        self.name = name
        self.money = money
        self.isPlaying = isPlaying
    }
    
    static func == (lhs: Player, rhs: Player) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(money)
        hasher.combine(isPlaying)
    }
}

