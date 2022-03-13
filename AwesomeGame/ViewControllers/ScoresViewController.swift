//
//  ScoresViewController.swift
//  AwesomeGame
//
//  Created by Александра Широкова on 13.03.2022.
//

import UIKit

class ScoresViewController: UIViewController {

    @IBOutlet weak var triesCountHumanLabel: UILabel!
    @IBOutlet weak var triesCountComputerLabel: UILabel!
    
    @IBOutlet weak var resultGameLabel: UILabel!
    
    var playerHuman: Player!
    var playerComputer: Player!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    private func updateUI() {
        triesCountHumanLabel.text = "Your's ties count: \(playerHuman.countTries)"
        triesCountComputerLabel.text = "Computers's tries count: \(playerComputer.countTries)"
        
        if playerHuman.countTries < playerComputer.countTries {
            resultGameLabel.text = "You Win"
        }
        
        if playerHuman.countTries > playerComputer.countTries {
            resultGameLabel.text = "You fail"
        }
        
        if playerHuman.countTries == playerComputer.countTries {
            resultGameLabel.text = "Draw"
        }
    }
    
}
