//
//  CustomScrollView.swift
//  Passport
//
//  Created by Марк Акиваев on 2/16/22.
//

import UIKit

class CustomScrollView: UIScrollView {
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
