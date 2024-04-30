//
//  BallanceView.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import UIKit

class BallanceView: UIView {
    
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
    
    let ballanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Book", size: 30)
        return label
    }()
    
    let ballanceDollarLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Book", size: 18)
        return label
    }()
    
    func setupSubviews() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
        
        addSubview(ballanceLabel)
        ballanceLabel.text = "32.33333"
        addSubview(bitcoinImageView)
        addSubview(ballanceDollarLabel)
        ballanceDollarLabel.text = "$1805.33333"
        NSLayoutConstraint.activate([
            bitcoinImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            bitcoinImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            bitcoinImageView.widthAnchor.constraint(equalToConstant: 100),
            bitcoinImageView.heightAnchor.constraint(equalToConstant: 100),
            
            ballanceLabel.leftAnchor.constraint(equalTo: bitcoinImageView.rightAnchor, constant: 8),
            ballanceLabel.topAnchor.constraint(equalTo: bitcoinImageView.topAnchor),
            ballanceLabel.bottomAnchor.constraint(equalTo: centerYAnchor),
            ballanceLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            
            ballanceDollarLabel.leftAnchor.constraint(equalTo: bitcoinImageView.rightAnchor, constant: 8),
            ballanceDollarLabel.topAnchor.constraint(equalTo: ballanceLabel.bottomAnchor),
            ballanceDollarLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
        ])
    }
    
    
}
