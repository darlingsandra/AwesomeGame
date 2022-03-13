//
//  Player.swift
//  AwesomeGame
//
//  Created by Александра Широкова on 12.03.2022.
//

struct Player {
    let type: PlayerType
    var number: Int = 0
    var triesCount: Int = 0
}

enum PlayerType {
    case computer
    case human
}

enum StepGame {
    case enterNumber
    case computerGame
    case humanGame
}
