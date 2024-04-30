//
//  CategoryCell.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: "Avenir-Book", size: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(categoryLabel)
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            categoryLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
