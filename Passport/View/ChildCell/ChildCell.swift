//
//  ChildCell.swift
//  Passport
//
//  Created by Марк Акиваев on 2/16/22.
//

import UIKit

class ChildCell: UIView {
    
    let nameTextField = CustomTextField(placeholder: "Enter your child name")
    let ageTextField = CustomTextField(placeholder: "Enter your child age", keyboardType: .numberPad)
    
    let deleteChildButton = DeleteChildButton()
    
    weak var topConstraint: NSLayoutConstraint?
    
    init() {
        super.init(frame: .zero)
        
        // Cell customization
        self.backgroundColor = UIColor(named: "CellBG")
        self.layer.cornerRadius = 5
        self.clipsToBounds = true
        
        
        // MARK: Setup layout
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(deleteChildButton)
        self.addSubview(nameTextField)
        self.addSubview(ageTextField)
        
        
        NSLayoutConstraint.activate([
            deleteChildButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            deleteChildButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            deleteChildButton.widthAnchor.constraint(equalToConstant: 75),
            
            nameTextField.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: deleteChildButton.leadingAnchor, constant: -20),
            
            ageTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 5),
            ageTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            ageTextField.trailingAnchor.constraint(equalTo: deleteChildButton.leadingAnchor, constant: -20),
            ageTextField.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
