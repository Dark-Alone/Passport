//
//  CustomLabel.swift
//  Passport
//
//  Created by Марк Акиваев on 2/16/22.
//

import UIKit

class CustomLabel: UILabel {
    
    init(text: String) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.font = .systemFont(ofSize: 22, weight: .medium)
        
        self.text = text
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
