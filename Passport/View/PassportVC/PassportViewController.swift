//
//  ViewController.swift
//  Passport
//
//  Created by Марк Акиваев on 2/15/22.
//

import UIKit

class PassportViewController: UIViewController {
    // Top label
    let personalLabel: UILabel = CustomLabel(text: "Passport")

    // MARK: Personal data
    let nameTextField: UITextField = CustomTextField(placeholder: "Enter your name")
    let surnameTextField: UITextField = CustomTextField(placeholder: "Enter your surname")
    let patronimycTextField: UITextField = CustomTextField(placeholder: "Enter your patronimyc")
    let ageTextField: UITextField = CustomTextField(placeholder: "Entrer your age", keyboardType: .numberPad)

    let childLabel: UILabel = CustomLabel(text: "Childs(max 5)")
    let addChildButton: UIButton = AddChildButton()

    var childCells = [ChildCell]()
    
    let resetButton = ResetButton()

    let scrollView: UIScrollView = CustomScrollView()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupBasicLayout()
        self.setupBackgroundColor()
        self.setupBasicTags()
        self.setupTextFieldsDelegate()
        self.setupTapOutsideKeyboard()

        // Setting up buttons target
        addChildButton.addTarget(self, action: #selector(addChildView), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetView), for: .touchUpInside)
    }

    func setupBasicLayout() {
        self.view.addSubview(scrollView)

        self.scrollView.addSubview(personalLabel)
        self.scrollView.addSubview(nameTextField)
        self.scrollView.addSubview(surnameTextField)
        self.scrollView.addSubview(patronimycTextField)
        self.scrollView.addSubview(ageTextField)
        self.scrollView.addSubview(childLabel)
        self.scrollView.addSubview(addChildButton)
        self.scrollView.addSubview(resetButton)

        let safeArea = self.view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),


            personalLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            personalLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),

            nameTextField.topAnchor.constraint(equalTo: personalLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            nameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),

            surnameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 10),
            surnameTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            surnameTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),

            patronimycTextField.topAnchor.constraint(equalTo: surnameTextField.bottomAnchor, constant: 10),
            patronimycTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            patronimycTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),

            ageTextField.topAnchor.constraint(equalTo: patronimycTextField.bottomAnchor, constant: 10),
            ageTextField.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            ageTextField.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),


            childLabel.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 30),
            childLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),

            addChildButton.centerYAnchor.constraint(equalTo: childLabel.centerYAnchor),
            addChildButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            
            resetButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            resetButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
    }
    
    func setupBackgroundColor() {
        // Support dark mode
        scrollView.backgroundColor = UIColor(named: "BG")
        view.backgroundColor = UIColor(named: "BG")
    }
    
    func setupBasicTags() {
        self.nameTextField.tag = 1
        self.surnameTextField.tag = 2
        self.patronimycTextField.tag = 3
        self.ageTextField.tag = 4
    }
    
    func setupTextFieldsDelegate() {
        self.nameTextField.delegate = self
        self.surnameTextField.delegate = self
        self.patronimycTextField.delegate = self
        self.ageTextField.delegate = self
    }
    
    func setupTapOutsideKeyboard() {
        self.scrollView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(_:))))
    }
    
    func resetButtonUpdateTopConstraint(with toView: UIView) {
        // resetButton update top constraint
        resetButton.topConstraint?.isActive = false
        let rbNewTopConstraint = resetButton.topAnchor.constraint(equalTo: toView.bottomAnchor, constant: 15)
        resetButton.topConstraint = rbNewTopConstraint
        rbNewTopConstraint.isActive = true
    }
}


extension PassportViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: textField.superview!.frame.origin.y), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let tag = textField.tag
        
        makeFirstResponder(tag: tag + 1)
        
        return true
    }
    
    func makeFirstResponder(tag: Int) {
        if let findTextField = view.viewWithTag(tag) as? UITextField {
            findTextField.becomeFirstResponder()
        } else {
            self.view.endEditing(true)
        }
    }
}
