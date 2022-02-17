//
//  DeleteChildButton.swift
//  Passport
//
//  Created by Марк Акиваев on 2/17/22.
//

import UIKit

class DeleteChildButton: CustomButton {
    
    override init() {
        super.init()
        
        self.setTitle("Delete", for: .normal)
        self.setTitleColor(UIColor(named: "Red"), for: .normal)
        self.layer.cornerRadius = 5
        self.backgroundColor = UIColor(named: "ButtonBG")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
