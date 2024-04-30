//
//  CustomButton.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import UIKit

class CustomButton: UIButton {
    
    var startColor: UIColor = UIColor.tintColor {
        didSet {
            updateGradient()
        }
    }
    var endColor: UIColor = UIColor.tintColor {
        didSet {
            updateGradient()
        }
    }
    
    let gradientLayer = CAGradientLayer()
    
    override func draw(_ rect: CGRect) {
        gradientLayer.frame = rect
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
        layer.cornerRadius = rect.height / 2
        clipsToBounds = true
        addTarget(self, action: #selector(touchDown), for: .touchDown)
        addTarget(self, action: #selector(touchUp), for: .touchUpInside)
        addTarget(self, action: #selector(touchUp), for: .touchDragExit)
    }
    
    func updateGradient() {
        gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
    
    @objc func touchDown() {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 0.8
        }
    }
    
    @objc func touchUp() {
        UIView.animate(withDuration: 0.1) {
            self.alpha = 1.0
        }
    }
    
}
