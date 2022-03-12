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
    
    private let defaultRange = 1...100
    
    private var playerHyman = Player(type: .hyman)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enterNumberTF.delegate = self
        updateViewButton(textField: enterNumberTF, button: enterNumberButton)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(false)
    }
    
    @IBAction func enterNumberButtonPressed() {
        guard let text = enterNumberTF.text, let number = Int(text) else { return }
        playerHyman.number = number
    }
    
}

// MARK: - Private Methods
extension GameViewController {
    
    @objc private func didTapDone(textField: UITextField) {
        self.view.endEditing(false)
    }
    
    private func updateViewButton(textField: UITextField, button: UIButton) {
        guard let text = textField.text, let number = Int(text), defaultRange.contains(number) else {
            button.isEnabled = false
            return
        }
        button.isEnabled = true
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
