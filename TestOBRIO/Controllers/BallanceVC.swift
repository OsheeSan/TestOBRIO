//
//  BallanceVC.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import UIKit

class BallanceVC: UIViewController {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "BlueGradient")
        return imageView
    }()
    
    let ballanceView = BallanceView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLabel()
    }
    
    func setupLabel() {
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.frame
        ballanceView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ballanceView)
        NSLayoutConstraint.activate([
            ballanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            ballanceView.heightAnchor.constraint(equalToConstant: CGFloat(BallanceView.normalHeight)),
            ballanceView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            ballanceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8)
        ])
    }


}


