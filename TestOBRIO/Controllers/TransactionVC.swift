//
//  ViewController.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import UIKit

class TransactionVC: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "BlueGradient")
        return imageView
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Amount"
        textField.keyboardType = .decimalPad
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    let addButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Add Bitcoins", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 25)
        button.startColor = UIColor(cgColor: CGColor(red: 7/255, green: 35/255, blue: 115/255, alpha: 1))
        button.endColor = UIColor(cgColor: CGColor(red: 22/255, green: 91/255, blue: 171/255, alpha: 1))
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let backButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Back", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 18)
        button.startColor = UIColor(cgColor: CGColor(red: 7/255, green: 35/255, blue: 115/255, alpha: 1))
        button.endColor = UIColor(cgColor: CGColor(red: 22/255, green: 91/255, blue: 171/255, alpha: 1))
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.frame
        
        view.addSubview(amountTextField)
        view.addSubview(addButton)
        view.addSubview(backButton)
        
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amountTextField.bottomAnchor.constraint(equalTo: view.centerYAnchor, constant: -8),
            amountTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            amountTextField.widthAnchor.constraint(equalToConstant: 300),
            
            addButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 8),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 300),
            addButton.heightAnchor.constraint(equalToConstant: 50),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    @objc private func addButtonTapped() {
        self.dismiss(animated: true)
    }
    
    
}

