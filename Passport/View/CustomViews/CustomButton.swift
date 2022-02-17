//
//  CustomButton.swift
//  Passport
//
//  Created by Марк Акиваев on 2/16/22.
//

import UIKit

class CustomButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.configuration = .borderedProminent()
        self.tintColor = UIColor(named: "ButtonBG")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
