//
//  TransactionCell.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import UIKit

class TransactionCell: UITableViewCell {
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .gray
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Book", size: 10)
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Book", size: 20)
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Book", size: 16)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        addSubview(timeLabel)
        addSubview(amountLabel)
        addSubview(categoryLabel)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        amountLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            timeLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            timeLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            
            amountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            amountLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            categoryLabel.topAnchor.constraint(equalTo: amountLabel.bottomAnchor, constant: 4),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
