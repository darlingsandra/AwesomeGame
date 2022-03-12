//
//  CompareButton.swift
//  AwesomeGame
//
//  Created by Александра Широкова on 12.03.2022.
//

import UIKit

class CompareButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            //backgroundColor = isEnabled ? backgroundColor?.withAlphaComponent(1) :  backgroundColor?.withAlphaComponent(0.3)
            backgroundColor = isEnabled ? .white : .lightGray
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setStyleCustom()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setStyleCustom()
    }
    
    func setStyleCustom() {
        self.layer.cornerRadius = self.frame.size.height / 4
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal)
        self.setTitleColor(.black, for: .disabled)
    }
}
