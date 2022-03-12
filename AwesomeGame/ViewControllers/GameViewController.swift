//
//  GameViewController.swift
//  AwesomeGame
//
//  Created by Александра Широкова on 11.03.2022.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var enterNumberButton: MainButton!
    @IBOutlet weak var enterNumberTF: UITextField!
    
    @IBOutlet weak var enterNumberStackView: UIStackView!
    @IBOutlet weak var computerGameStackView: UIStackView!
    
    @IBOutlet weak var countTriesComputerLabel: UILabel!
    @IBOutlet weak var numberComputerLabel: UILabel!
    
    @IBOutlet weak var greaterButton: CompareButton!
    @IBOutlet weak var equallyButton: CompareButton!
    @IBOutlet weak var lessButton: CompareButton!
    
    private let defaultRange = 1...100
    private var currentRange = 1...100
    
    private var currentStepGame: StepGame = .enterNumber
    private var currentGuessNumber: Int = 0
    
    private var playerHyman = Player(type: .hyman)
    private var playerComputer = Player(type: .computer)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterNumberTF.delegate = self
        updateUI()
        updateViewButton(textField: enterNumberTF, button: enterNumberButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    @IBAction func enterNumberButtonPressed() {
        guard let text = enterNumberTF.text, let number = Int(text) else { return }
        playerHyman.number = number
        
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
    }
    
}

// MARK: - Private Methods
extension GameViewController {
    
    @objc private func didTapDone(textField: UITextField) {
        self.view.endEditing(false)
    }
    
    private func updateUI(){
        for stackView in [enterNumberStackView, computerGameStackView] {
            stackView?.isHidden = true
        }
        
        switch currentStepGame {
        case .enterNumber:
            enterNumberStackView.isHidden.toggle()
        case .computerGame:
            computerGameStackView.isHidden.toggle()
        case .hymanGame:
            computerGameStackView.isHidden.toggle()
        }
    }
    
    private func updateComputerGameView() {
        countTriesComputerLabel.text = "Try № \(playerComputer.countTries)"
        numberComputerLabel.text = "Your number is - \(currentGuessNumber) ?"
        
        for button in [greaterButton, equallyButton, lessButton] {
            button!.isEnabled = false
        }
        
        if currentGuessNumber < playerHyman.number {
            greaterButton.isEnabled.toggle()
        }
        
        if currentGuessNumber > playerHyman.number {
            lessButton.isEnabled.toggle()
        }
        
        if currentGuessNumber == playerHyman.number {
            equallyButton.isEnabled.toggle()
        }
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
        playerComputer.countTries += 1
        updateComputerGameView()
    }
    
}

// MARK: - UITextFieldDelegate
extension GameViewController: UITextFieldDelegate {
        
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField == enterNumberTF {
            updateViewButton(textField: textField, button: enterNumberButton)
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
