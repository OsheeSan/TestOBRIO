//
//  BallanceView.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import UIKit

///Protocol for triggering BalanceView's ViewController
protocol BalanceViewDelegate {
    func addBalanceTap()
}

///Bitcoin balance view
class BalanceView: UIView {
    
    ///VC where BalanceView is added
    var delegate: BalanceViewDelegate?
    
    //Recommended height
    static let normalHeight = 150
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    let bitcoinImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "bitcoinIcon")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let balanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Book", size: 30)
        return label
    }()
    
    let balanceDollarLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Book", size: 18)
        return label
    }()
    
    let addBalanceButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Add", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 16)
        button.startColor = UIColor(cgColor: CGColor(red: 7/255, green: 35/255, blue: 115/255, alpha: 1))
        button.endColor = UIColor(cgColor: CGColor(red: 22/255, green: 91/255, blue: 171/255, alpha: 1))
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupSubviews() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        
        addSubview(balanceLabel)
        addSubview(bitcoinImageView)
        addSubview(balanceDollarLabel)
        
        addSubview(addBalanceButton)
        addBalanceButton.addTarget(self, action: #selector(addButtonTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            bitcoinImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            bitcoinImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            bitcoinImageView.widthAnchor.constraint(equalToConstant: 100),
            bitcoinImageView.heightAnchor.constraint(equalToConstant: 100),
            
            balanceLabel.leftAnchor.constraint(equalTo: bitcoinImageView.rightAnchor, constant: 8),
            balanceLabel.topAnchor.constraint(equalTo: bitcoinImageView.topAnchor),
            balanceLabel.bottomAnchor.constraint(equalTo: centerYAnchor),
            balanceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            
            balanceDollarLabel.leftAnchor.constraint(equalTo: bitcoinImageView.rightAnchor, constant: 8),
            balanceDollarLabel.topAnchor.constraint(equalTo: balanceLabel.bottomAnchor),
            balanceDollarLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            
            addBalanceButton.leftAnchor.constraint(equalTo: bitcoinImageView.rightAnchor, constant: 8),
            addBalanceButton.topAnchor.constraint(equalTo: balanceDollarLabel.bottomAnchor, constant: 8),
            addBalanceButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            addBalanceButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
        ])
    }
    
    @objc func addButtonTap() {
        guard let delegate = delegate else {
            return
        }
        delegate.addBalanceTap()
    }
    
    func setAmount(_ amount: Double) {
        self.balanceLabel.text = "\(amount)"
    }
    
    func setAmountDollars(_ amount: Double) {
        self.balanceDollarLabel.text = "$\(amount)"
    }
    
    
}
