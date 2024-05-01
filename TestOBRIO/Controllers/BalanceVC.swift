//
//  BallanceVC.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import UIKit

///First Screen with bitcoin's amount, transactions list
class BalanceVC: UIViewController, BalanceViewDelegate {
    
    let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: "BlueGradient")
        return imageView
    }()
    
    let addTransactionButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Add Transaction", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Book", size: 30)
        button.startColor = UIColor(cgColor: CGColor(red: 7/255, green: 35/255, blue: 115/255, alpha: 1))
        button.endColor = UIColor(cgColor: CGColor(red: 22/255, green: 91/255, blue: 171/255, alpha: 1))
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let balanceView = BalanceView()
    
    func addBalanceTap() {
        let popupView = PopupAddBalanceView(frame: view.frame)
        popupView.delegate = self
        self.view.addSubview(popupView)
        popupView.alpha = 0
        UIView.transition(with: view, duration: 0.3, animations: {
            popupView.alpha = 1
        }) {
            completion in
        }
        
    }
    
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BalanceManager.shared.presenter = self
        setupSubviews()
        loadBallanceData()
    }
    
    ///Loading first data
    private func loadBallanceData() {
        balanceView.setAmount(BalanceManager.shared.getBitcoins())
        balanceView.setAmountDollars(BalanceManager.shared.getBitcoinsInDollars())
    }
    
    ///Update View
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        BalanceManager.shared.reloadData()
        tableView.reloadData()
    }
    
    func setupSubviews() {
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.frame
        balanceView.translatesAutoresizingMaskIntoConstraints = false
        balanceView.delegate = self
        view.addSubview(balanceView)
        view.addSubview(addTransactionButton)
        addTransactionButton.addAction(UIAction() {
            _ in
            let vc = TransactionVC()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        NSLayoutConstraint.activate([
            balanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            balanceView.heightAnchor.constraint(equalToConstant: CGFloat(BalanceView.normalHeight)),
            balanceView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            balanceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            
            addTransactionButton.topAnchor.constraint(equalTo: balanceView.bottomAnchor, constant: 8),
            addTransactionButton.heightAnchor.constraint(equalToConstant: 60),
            addTransactionButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            addTransactionButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TransactionCell.self, forCellReuseIdentifier: "TransactionCell")
        tableView.register(TransactionHeaderView.self, forHeaderFooterViewReuseIdentifier: TransactionHeaderView.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = .zero
        tableView.clipsToBounds = true
        tableView.layer.cornerRadius = 25
        tableView.separatorColor = .white
        tableView.backgroundColor = .clear
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: addTransactionButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    ///Loading more transaction, adding new section, rows in TableView
    func loadMore() {
        let currentSections = BalanceManager.shared.getTransactionGroups()
        BalanceManager.shared.fetcthTransactions()
        let updatedSections = BalanceManager.shared.getTransactionGroups()
        var indexPaths = [IndexPath]()
        var newSections = [Int]()
        
        //If there are no new Sections
        if currentSections.count == updatedSections.count {
            if currentSections[currentSections.count-1].transactions.count < updatedSections[currentSections.count-1].transactions.count {
                for i in currentSections[currentSections.count-1].transactions.count..<updatedSections[currentSections.count-1].transactions.count {
                    print(i, currentSections.count-1)
                    indexPaths.append(IndexPath(row: i, section: currentSections.count-1))
                }
            }
            //If there are new Sections
        } else if currentSections.count < updatedSections.count {
            if currentSections[currentSections.count-1].transactions.count < updatedSections[currentSections.count-1].transactions.count {
                for i in currentSections[currentSections.count-1].transactions.count..<updatedSections[currentSections.count-1].transactions.count {
                    print(i, currentSections.count-1)
                    indexPaths.append(IndexPath(row: i, section: currentSections.count-1))
                }
            }
            for newSectionIndex in currentSections.count..<updatedSections.count {
                newSections.append(newSectionIndex)
                for i in 0..<updatedSections[newSectionIndex].transactions.count {
                    indexPaths.append(IndexPath(row: i, section: newSectionIndex))
                }
            }
        }
        
        if !newSections.isEmpty && !indexPaths.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute:  {
                self.tableView.beginUpdates()
                self.tableView.insertSections(IndexSet(newSections), with: .automatic)
                self.tableView.insertRows(at: indexPaths, with: .automatic)
                self.tableView.endUpdates()
            })
        } else if !indexPaths.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute:  {
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: indexPaths, with: .automatic)
                self.tableView.endUpdates()
            })
        }
        
    }
    
    
}

extension BalanceVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return BalanceManager.shared.getTransactionGroups().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return BalanceManager.shared.getTransactionGroups()[section].transactions.count
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        nil
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TransactionCell", for: indexPath) as! TransactionCell
        
        let transaction = BalanceManager.shared.getTransactionGroups()[indexPath.section].transactions[indexPath.row]
        
        cell.configure(with: transaction)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: TransactionHeaderView.reuseIdentifier) as! TransactionHeaderView
        let date = BalanceManager.shared.getTransactionGroups()[section].date
        headerView.configure(date: date)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == BalanceManager.shared.getTransactionGroups().count - 1 {
            if indexPath.row == BalanceManager.shared.getTransactionGroups()[indexPath.section].transactions.count - 1 {
                self.loadMore()
            }
        }
    }
    
}

extension BalanceVC: BalancePresenter {
    ///Update TableView
    func updateTransactions() {
        BalanceManager.shared.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.tableView.reloadData()
        })
    }
    
    ///Update BallanceView
    func updateBalance() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
            self.balanceView.setAmount(BalanceManager.shared.getBitcoins())
            self.balanceView.setAmountDollars(BalanceManager.shared.getBitcoinsInDollars())
        })
    }
}



