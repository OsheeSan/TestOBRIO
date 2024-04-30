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
    
    let addBallanceButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Add Ballance", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 30)
        button.startColor = UIColor(cgColor: CGColor(red: 7/255, green: 35/255, blue: 115/255, alpha: 1))
        button.endColor = UIColor(cgColor: CGColor(red: 22/255, green: 91/255, blue: 171/255, alpha: 1))
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let ballanceView = BallanceView()
    
    let tableView = UITableView()
    
    let ballanceViewModel = BallanceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        ballanceViewModel.addTransactions(TransactionTestDataSource.transactions)
        tableView.reloadData()
    }
    
    func setupSubviews() {
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.frame
        ballanceView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(ballanceView)
        view.addSubview(addBallanceButton)
        NSLayoutConstraint.activate([
            ballanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            ballanceView.heightAnchor.constraint(equalToConstant: CGFloat(BallanceView.normalHeight)),
            ballanceView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            ballanceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            
            addBallanceButton.topAnchor.constraint(equalTo: ballanceView.bottomAnchor, constant: 8),
            addBallanceButton.heightAnchor.constraint(equalToConstant: 60),
            addBallanceButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            addBallanceButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        tableView.register(TransactionHeaderView.self, forHeaderFooterViewReuseIdentifier: TransactionHeaderView.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = .zero
        tableView.separatorColor = .white
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addBallanceButton.bottomAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}

extension BallanceVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return ballanceViewModel.getTransactionGroups().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ballanceViewModel.getTransactionGroups()[section].transactions.count
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
       
        let transaction = ballanceViewModel.getTransactionGroups()[indexPath.section].transactions[indexPath.row]
        
        cell.configure(with: transaction)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TransactionHeaderView.reuseIdentifier) as! TransactionHeaderView
        let date = ballanceViewModel.getTransactionGroups()[section].date
        headerView.configure(date: date)
        return headerView
    }
    
}




