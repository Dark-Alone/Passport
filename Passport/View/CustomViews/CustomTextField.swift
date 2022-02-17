//
//  CustomTextField.swift
//  Passport
//
//  Created by Марк Акиваев on 2/15/22.
//

import UIKit

class CustomTextField: UITextField {
    
    init(placeholder: String, keyboardType: UIKeyboardType = .default) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.placeholder = placeholder
        
        self.borderStyle = .roundedRect
        self.keyboardType = keyboardType
    }
    
    required init?(coder: NSCoder) {
        fatalError("customTextField required init")
    }
}
