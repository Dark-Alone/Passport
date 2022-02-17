//
//  AddChildButton.swift
//  Passport
//
//  Created by Марк Акиваев on 2/16/22.
//

import UIKit

class AddChildButton: CustomButton {
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.sizeToFit()
        imageView.contentScaleFactor = 0.1
        
        return imageView
    }()
    
    private let textLabel = CustomLabel(text: "Add child")
    
    override init() {
        super.init()
        
        guard let blueColor = UIColor(named: "Blue") else {
            fatalError("this is disaster!")
        }
        iconView.image = UIImage(systemName: "plus")?.withTintColor(blueColor)
        iconView.tintColor = blueColor
        
        let font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textLabel.font = font
        
        textLabel.textColor = blueColor
        
        // MARK: Setup Layout
        self.addSubview(iconView)
        self.addSubview(textLabel)
        
        
        NSLayoutConstraint.activate([
            iconView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            iconView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            iconView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            iconView.widthAnchor.constraint(equalToConstant: 20),
            iconView.heightAnchor.constraint(equalToConstant: 20),
            
            
            textLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            textLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 5),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension AddChildButton {
//    // fix animation
//    @objc func animateStart() {
//        UIView.animate(withDuration: 0.1) {
//            self.layer.opacity = 0.7
//        }
//    }
//
//    @objc func animateEnd() {
//        UIView.animate(withDuration: 0.1) {
//            self.layer.opacity = 1
//        }
//    }
//}
