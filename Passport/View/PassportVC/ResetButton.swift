//
//  ResetButton.swift
//  Passport
//
//  Created by Марк Акиваев on 2/17/22.
//

import UIKit

class ResetButton: CustomButton {
    
    weak var topConstraint: NSLayoutConstraint?
    
    override init() {
        super.init()
        
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        self.backgroundColor = UIColor(named: "ButtonBG")
        self.configuration = .bordered()
        
        self.titleLabel?.font = .systemFont(ofSize: 15)
        UIView.performWithoutAnimation {
            self.setTitle("Reset", for: .normal)
            self.setTitleColor(UIColor(named: "Red"), for: .normal)
            self.layoutIfNeeded()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
