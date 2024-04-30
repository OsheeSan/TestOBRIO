//
//  BallanceVC.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import UIKit

class BallanceVC: UIViewController, BallanceViewDelegate {
    
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
    
    let ballanceView = BallanceView()
    
    func addBallanceTap() {
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
    
    let ballanceViewModel = BallanceViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ballanceViewModel.reloadData()
        tableView.reloadData()
    }
    
    func setupSubviews() {
        view.addSubview(backgroundImageView)
        backgroundImageView.frame = view.frame
        ballanceView.translatesAutoresizingMaskIntoConstraints = false
        ballanceView.delegate = self
        view.addSubview(ballanceView)
        view.addSubview(addTransactionButton)
        addTransactionButton.addAction(UIAction() {
            _ in
            let vc = TransactionVC()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        NSLayoutConstraint.activate([
            ballanceView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            ballanceView.heightAnchor.constraint(equalToConstant: CGFloat(BallanceView.normalHeight)),
            ballanceView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8),
            ballanceView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8),
            
            addTransactionButton.topAnchor.constraint(equalTo: ballanceView.bottomAnchor, constant: 8),
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
    
    func loadMore() {
        let currentSections = ballanceViewModel.getTransactionGroups()
        ballanceViewModel.fetcthTransactions()
        let updatedSections = ballanceViewModel.getTransactionGroups()
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == ballanceViewModel.getTransactionGroups().count - 1 {
            if indexPath.row == ballanceViewModel.getTransactionGroups()[indexPath.section].transactions.count - 1 {
                self.loadMore()
            }
        }
    }
    
}




