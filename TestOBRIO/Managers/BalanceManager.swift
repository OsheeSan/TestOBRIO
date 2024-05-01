//
//  BallanceViewModel.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import Foundation

protocol BalancePresenter {
    func updateTransactions()
    func updateBalance()
}

class BalanceManager {
    
    public static var shared = BalanceManager()
    
    var presenter: BalancePresenter?
    
    private var exchange: Double = 1
    
    private var bitcoinsAmount: Double = 3
    
    private var transactionGroups: [Date: TransactionGroup] = [:]
    
    func addTransactions(_ transactions: [Transaction]) {
        transactions.forEach({
            transaction in
            let dateKey = dateWithoutTime(transaction.date)
            if self.transactionGroups[dateWithoutTime(dateKey)] == nil {
                self.transactionGroups[dateWithoutTime(dateKey)] = TransactionGroup(date: dateKey, transactions: [transaction])
            } else {
                self.transactionGroups[dateKey]!.transactions.append(transaction)
            }
        })
    }
    
    func getBitcoins() -> Double {
        bitcoinsAmount = CoreDataManager.shared.getBitcoinValue()
        return bitcoinsAmount
    }
    
    func addBitcoins(_ amount: Double) {
        CoreDataManager.shared.createTransaction(amount: amount, date: Date(), category: "")
        CoreDataManager.shared.addBitcoins(amount)
        presenter?.updateTransactions()
        presenter?.updateBalance()
    }
    
    func takeBitcoins(_ amount: Double) {
        print("Taking \(amount) bitcoins... on ballance \(getBitcoins())")
        if CoreDataManager.shared.getBitcoinValue() >= amount {
            CoreDataManager.shared.takeBitcoins(amount)
        }
        bitcoinsAmount = CoreDataManager.shared.getBitcoinValue()
        presenter?.updateTransactions()
        presenter?.updateBalance()
    }
    
    func getBitcoinsInDollars() -> Double {
        exchange * bitcoinsAmount
    }
    
    func setExchange(_ exchange: Double) {
        self.exchange = exchange
        presenter?.updateBalance()
    }
    
    func reloadData() {
        transactionGroups = [:]
        CoreDataManager.shared.offset = 0
        let newTransactions = CoreDataManager.shared.fetchTransactions()
        addTransactions(newTransactions)
    }
    
    func fetcthTransactions() {
        let newTransactions = CoreDataManager.shared.fetchTransactions()
        addTransactions(newTransactions)
    }
    
    func getTransactionGroups() -> [TransactionGroup] {
        transactionGroups.values.sorted { $0.date > $1.date }
    }
    
    private func dateWithoutTime(_ date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components)!
    }
    
}
