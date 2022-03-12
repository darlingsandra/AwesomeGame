//
//  Player.swift
//  AwesomeGame
//
//  Created by Александра Широкова on 12.03.2022.
//

struct Player {
    let type: TypePlayer
    var number: Int = 0
    var countTries: Int = 0
}

enum TypePlayer {
    case computer
    case hyman
}
