//
//  PassportVC+objc.swift
//  Passport
//
//  Created by Марк Акиваев on 2/17/22.
//

import UIKit

extension PassportViewController {
    
    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc func addChildView() {
        let childCell = ChildCell()

        // topConstraint for new childView
        let topConstraint: NSLayoutConstraint
       
        if let lastCell = childCells.last {
            topConstraint = childCell.topAnchor.constraint(equalTo: lastCell.bottomAnchor, constant: 20)
        } else {
            topConstraint = childCell.topAnchor.constraint(equalTo: childLabel.bottomAnchor, constant: 20)
        }
        
        // configure childCell text fields
        childCell.nameTextField.delegate = self
        childCell.ageTextField.delegate = self
        childCell.nameTextField.tag = 5 + childCells.count * 2
        childCell.ageTextField.tag = 5 + childCells.count * 2 + 1
 
        // Configure deleteChildButton
        childCell.deleteChildButton.addTarget(self, action: #selector(deleteChildView(sender:)), for: .touchUpInside)
        childCell.deleteChildButton.tag = childCells.count + 20

        // childCell variables
        self.scrollView.addSubview(childCell)
        childCell.topConstraint = topConstraint

        // MARK: Animation new cell
        let safeArea = self.view.safeAreaLayoutGuide
        let animationTrailingConstraint = childCell.trailingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: -10)

        NSLayoutConstraint.activate([
            topConstraint,
            animationTrailingConstraint,
        ])

        scrollView.layoutIfNeeded()

        animationTrailingConstraint.isActive = false

        NSLayoutConstraint.activate([
            childCell.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10),
            childCell.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10),
        ])

        UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromLeft) {
            self.scrollView.layoutIfNeeded()
        }
        
        resetButtonUpdateTopConstraint(with: childCell)
        
        if childCells.isEmpty {
            resetButton.layer.opacity = 0
            UIView.animate(withDuration: 0.5) {
                self.resetButton.layer.opacity = 1
            }
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromTop) {
                self.scrollView.layoutIfNeeded()
            }
        }
        
        // childCells
        childCells.append(childCell)
        
        if self.childCells.count == 5 {
            UIView.animate(withDuration: 0.5) {
                self.addChildButton.layer.opacity = 0
            }
        }
    }

    @objc func deleteChildView(sender: UIButton) {
        let index = sender.tag - 20
        let senderCell = childCells[index]
        
        // TODO: bug - reset disappears when deleting last cell
        if index == 0 && childCells.count > 1 {
            let secondCell = childCells[1]
            
            if let oldConstraint = secondCell.topConstraint {
                oldConstraint.isActive = false
            }
            
            let topConstraint = secondCell.topAnchor.constraint(equalTo: childLabel.bottomAnchor, constant: 20)
            secondCell.topConstraint = topConstraint
            topConstraint.isActive = true
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromBottom, animations: {
                self.scrollView.layoutIfNeeded()
            }, completion: nil)
            
        } else if childCells.count - index >= 2 {
            // if deleting cell have next cell, give this cell top constraint of deleting
            let nextCell = childCells[index + 1]
            
            if let oldConstraint = nextCell.topConstraint {
                oldConstraint.isActive = false
            }
            
            let topConstraint = nextCell.topAnchor.constraint(equalTo: childCells[index - 1].bottomAnchor, constant: 20)
            nextCell.topConstraint = topConstraint
            topConstraint.isActive = true
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromBottom, animations: {
                self.scrollView.layoutIfNeeded()
            }, completion: nil)
            
        } else if childCells.count >= 2 && childCells.count - index == 1  {
            // if deleting cell is last and it is  layout reset button
            resetButtonUpdateTopConstraint(with: childCells[index - 1])
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .transitionFlipFromBottom, animations: {
                self.scrollView.layoutIfNeeded()
            }, completion: nil)
            
        } else {
            // remove last cell and hide reset button with fade animation
            UIView.animate(withDuration: 0.5) {
                self.resetButton.layer.opacity = 0
                senderCell.layer.opacity = 0
            } completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    senderCell.deleteChildButton.removeTarget(nil, action: nil, for: .allEvents)
                    senderCell.removeFromSuperview()
                }
            }
        }
        
        // removing 1 from child under deleting cell
        for i in index..<childCells.count {
            childCells[i].deleteChildButton.tag -= 1
            childCells[i].nameTextField.tag -= 2
            childCells[i].ageTextField.tag -= 2
        }
        
        // remove without animation
        if childCells.count != 1 {
            senderCell.deleteChildButton.removeTarget(nil, action: nil, for: .allEvents)
            senderCell.removeFromSuperview()
        }
        
        // show addChildButton
        if childCells.count == 5 {
            UIView.animate(withDuration: 0.5) {
                self.addChildButton.layer.opacity = 1
            }
        }

        childCells.remove(at: index)
        print("remove at \(index)")
        print(childCells.count)
    }
    
    @objc func resetView() {
        let alert = UIAlertController(title: "Reset", message: "Do you want to reset all entered data?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in
            print("cancel button")
        }))
        
        alert.addAction(UIAlertAction(title: "Reset", style: .destructive, handler: { action in
            UIView.transition(with: self.scrollView, duration: 1, options: .transitionFlipFromLeft, animations: {
                self.nameTextField.text = ""
                self.ageTextField.text = ""
                self.surnameTextField.text = ""
                self.patronimycTextField.text = ""
                
                self.childCells.forEach { cell in
                    cell.deleteChildButton.removeTarget(nil, action: nil, for: .allEvents)
                    cell.removeFromSuperview()
                }
                self.childCells.removeAll()
                
                self.addChildButton.layer.opacity = 1
                self.resetButton.layer.opacity = 0
                self.resetButton.topConstraint?.isActive = false
            }, completion: nil)
        }))
        
        self.present(alert, animated: true) {
            print("complete")
        }
    }
}
