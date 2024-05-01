//
//  PopupAddBalanceView.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import UIKit

class PopupAddBalanceView: UIView {
    
    var delegate: UIViewController?
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Amount"
        textField.font = UIFont(name: "Avenir-Book", size: 16)
        textField.backgroundColor = .clear
        textField.textAlignment = .center
        textField.textColor = .white
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    func setupSubviews() {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hide)))
        addSubview(blurEffectView)
        
        addSubview(amountTextField)
        addSubview(addButton)
        
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            amountTextField.bottomAnchor.constraint(equalTo: centerYAnchor, constant: -8),
            amountTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            amountTextField.widthAnchor.constraint(equalToConstant: 300),
            
            addButton.topAnchor.constraint(equalTo: amountTextField.bottomAnchor, constant: 8),
            addButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 300),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    @objc private func hide() {
        UIView.transition(with: self, duration: 0.3, animations: {
            self.alpha = 0
        }) {
            completion in
            self.removeFromSuperview()
        }
    }
    
    @objc private func addButtonTapped() {
        guard let amountString = amountTextField.text, let amount = Double(String(amountString.map {
            $0 == "," ? "." : $0
        })), amount > 0 else {
            let alert = UIAlertController(title: "Careful!", message: "Invalid amount", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            guard let delegate = delegate else {
                return
            }
            delegate.present(alert, animated: true, completion: nil)
            return
        }
        BalanceManager.shared.addBitcoins(amount)
        hide()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
