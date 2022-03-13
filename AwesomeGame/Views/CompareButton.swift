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
            backgroundColor = isEnabled ? .white : .lightGray
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setCustomStyle()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCustomStyle()
    }
    
    func setCustomStyle() {
        self.layer.cornerRadius = self.frame.size.height / 4
        self.layer.borderWidth = 1
        self.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.backgroundColor = .white
        self.setTitleColor(.black, for: .normal)
        self.setTitleColor(.black, for: .disabled)
    }
}
