//
//  TransactionHeaderView.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import UIKit

///Transaction Header for TableView
class TransactionHeaderView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = "TransactionHeaderView"
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.font = UIFont(name: "Avenir-Black", size: 18)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.clipsToBounds = true
        self.layer.cornerRadius = 25
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(date: Date) {
        let today = Calendar.current.startOfDay(for: Date())
            if Calendar.current.isDateInToday(date) {
                label.text = "Today"
            } else if Calendar.current.isDateInYesterday(date) {
                label.text = "Yesterday"
            } else {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy.MM.dd"
                label.text = dateFormatter.string(from: date)
            }
    }
}
