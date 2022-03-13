//
//  GameViewController.swift
//  AwesomeGame
//
//  Created by Александра Широкова on 11.03.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var enterNumberStackView: UIStackView!
    @IBOutlet weak var computerGameStackView: UIStackView!
    @IBOutlet weak var humanGameStackView: UIStackView!
    
    @IBOutlet weak var enterNumberButton: MainButton!
    @IBOutlet weak var enterNumberTF: UITextField!
    
    @IBOutlet weak var triesCountComputerLabel: UILabel!
    @IBOutlet weak var numberComputerLabel: UILabel!
    
    @IBOutlet weak var greaterButton: CompareButton!
    @IBOutlet weak var equallyButton: CompareButton!
    @IBOutlet weak var lessButton: CompareButton!
    
    @IBOutlet weak var triesCountHumanLabel: UILabel!
    @IBOutlet weak var guessNumberLabel: UILabel!
    @IBOutlet weak var guessNumberButton: MainButton!
    @IBOutlet weak var guessNumberTF: UITextField!
    
    private let defaultRange = 1...100
    private var currentRange = 1...100
    
    private var currentStepGame: StepGame = .enterNumber
    private var currentGuessNumber: Int = 0
    
    private var playerHuman = Player(type: .human)
    private var playerComputer = Player(type: .computer)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterNumberTF.delegate = self
        guessNumberTF.delegate = self
        updateUI()
        updateViewButton(textField: enterNumberTF, button: enterNumberButton)
        updateViewButton(textField: guessNumberTF, button: guessNumberButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let scoresVC = segue.destination as? ScoresViewController else { return }
        scoresVC.playerHuman = playerHuman
        scoresVC.playerComputer = playerComputer
    }
    
    @IBAction func enterNumberButtonPressed() {
        guard let text = enterNumberTF.text, let number = Int(text) else { return }
        playerHuman.number = number
        
        currentStepGame = .computerGame
        updateUI()
        
        nextGuessNumber()
    }
    
    @IBAction func greaterButtonPressed() {
        greaterNumber(range: &currentRange, number: currentGuessNumber)
        nextGuessNumber()
    }
    
    @IBAction func lessButtonPressed() {
        lessNumber(range: &currentRange, number: currentGuessNumber)
        nextGuessNumber()
    }
        
    @IBAction func equallyButtonPressed() {
        playerComputer.number = defaultRange.randomElement() ?? 1
        playerHuman.triesCount += 1
        currentGuessNumber = 0
        currentStepGame = .humanGame
        updateUI()
        updateHumanGameView()
    }
    
    @IBAction func guessNumberButtonPressed() {
        guard let text = guessNumberTF.text, let number = Int(text), defaultRange.contains(number) else { return }
        currentGuessNumber = number
        if playerComputer.number == currentGuessNumber {
            performSegue(withIdentifier: "showScores", sender: nil)
        }
        playerHuman.triesCount += 1
        updateHumanGameView()
    }
    
}

// MARK: - Private Methods
extension GameViewController {
    
    @objc private func didTapDone(textField: UITextField) {
        self.view.endEditing(false)
    }
    
    private func updateUI(){
        for stackView in [enterNumberStackView, computerGameStackView, humanGameStackView] {
            stackView!.isHidden = true
        }
        
        switch currentStepGame {
        case .enterNumber:
            enterNumberStackView.isHidden.toggle()
        case .computerGame:
            computerGameStackView.isHidden.toggle()
        case .humanGame:
            humanGameStackView.isHidden.toggle()
        }
    }
    
    private func updateComputerGameView() {
        triesCountComputerLabel.text = "Try № \(playerComputer.triesCount)"
        numberComputerLabel.text = "Your number is - \(currentGuessNumber) ?"
        
        greaterButton.isEnabled = currentGuessNumber < playerHuman.number
        lessButton.isEnabled = currentGuessNumber > playerHuman.number
        equallyButton.isEnabled = currentGuessNumber == playerHuman.number
    }
    
    private func updateHumanGameView() {
        triesCountHumanLabel.text = "Try № \(playerHuman.triesCount)"
        guessNumberLabel.isHidden = currentGuessNumber == 0
        
        var direction = "equally"
        
        if playerComputer.number < currentGuessNumber {
            direction = "less"
        }

        if playerComputer.number > currentGuessNumber {
            direction = "graeter"
        }
        
        guessNumberLabel.text = "Yes, my number is \(direction) yours"
    }
        
    private func updateViewButton(textField: UITextField, button: UIButton) {
        guard let text = textField.text, let number = Int(text), defaultRange.contains(number) else {
            button.isEnabled = false
            return
        }
        button.isEnabled = true
    }
    
    private func guessNumber(range: ClosedRange<Int>) -> Int {
        range.upperBound - range.lowerBound > 1
            ? (range.lowerBound + range.upperBound) / 2
            : range.randomElement() ?? range.upperBound
    }

    private func lessNumber(range: inout ClosedRange<Int>, number: Int) {
        range = range.lowerBound...number
    }

    private func greaterNumber(range: inout ClosedRange<Int>, number: Int) {
        range = number...range.upperBound
    }

    private func nextGuessNumber() {
        currentGuessNumber = guessNumber(range: currentRange)
        playerComputer.triesCount += 1
        updateComputerGameView()
    }
    
}

// MARK: - UITextFieldDelegate
extension GameViewController: UITextFieldDelegate {
        
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case enterNumberTF:
            updateViewButton(textField: textField, button: enterNumberButton)
        default:
            updateViewButton(textField: textField, button: guessNumberButton)
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {

        let keyBoardToolBar = UIToolbar()
        keyBoardToolBar.sizeToFit()

        let doneButton = UIBarButtonItem(
            barButtonSystemItem: .done,
            target: self,
            action: #selector(didTapDone)
        )

        let flexBarButton = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )

        keyBoardToolBar.items = [flexBarButton, doneButton]
        textField.inputAccessoryView = keyBoardToolBar

    }
}
