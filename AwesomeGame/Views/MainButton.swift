//
//  MainButton.swift
//  AwesomeGame
//
//  Created by Александра Широкова on 11.03.2022.
//

import UIKit

class MainButton: UIButton {
    override var isEnabled: Bool {
        didSet {
            backgroundColor = isEnabled
                ? backgroundColor?.withAlphaComponent(1)
                : backgroundColor?.withAlphaComponent(0.3)
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
        self.layer.cornerRadius = self.frame.size.height / 3
        self.backgroundColor = .blue
        self.setTitleColor(.white, for: .normal)
        self.setTitleColor(.white, for: .disabled)
    }
}
