//
//  BallanceViewModel.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import Foundation

/// Protocol for balance presenter
protocol BalancePresenter {
    func updateTransactions()
    func updateBalance()
}

/// Class for preparing data to show
class BalanceManager {
    
    public static var shared = BalanceManager()
    
    /// Presenter, view where we shoud show the data
    var presenter: BalancePresenter?
    
    /// Bitcoin exchange rate in dollars
    private var exchange: Double = 1
    
    /// Bitcoins amount
    private var bitcoinsAmount: Double = 3
    
    /// Dictionary of transactions grouped by it's Date
    private var transactionGroups: [Date: TransactionGroup] = [:]
    
    /// Add transaction to local dictionary
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
    
    /// Returns amount of bitcoins from CoreData model
    func getBitcoins() -> Double {
        bitcoinsAmount = BitcoinManager.shared.getBitcoinValue()
        return bitcoinsAmount
    }
    
    /// Adds bitcoin amount to CoreData model, updates presenter
    func addBitcoins(_ amount: Double) {
        TransactionsManager.shared.createTransaction(amount: amount, date: Date(), category: "")
        BitcoinManager.shared.addBitcoins(amount)
        presenter?.updateTransactions()
        presenter?.updateBalance()
    }
    
    /// Reduces the value of bitcoin count, updates presenter
    func takeBitcoins(_ amount: Double) {
        if BitcoinManager.shared.getBitcoinValue() >= amount {
            BitcoinManager.shared.takeBitcoins(amount)
        }
        bitcoinsAmount = BitcoinManager.shared.getBitcoinValue()
        presenter?.updateTransactions()
        presenter?.updateBalance()
    }
    
    /// Returns bitcoins price in dollars (Local exchange)
    func getBitcoinsInDollars() -> Double {
        exchange * bitcoinsAmount
    }
    
    /// Sets the bitcoin exchange rate
    func setExchange(_ exchange: Double) {
        BitcoinManager.shared.setBitcoinExchange(exchange)
        self.exchange = exchange
        presenter?.updateBalance()
    }
    
    /// Reloads local ballance and transactions data
    func reloadData() {
        transactionGroups = [:]
        TransactionsManager.shared.offset = 0
        let newTransactions = TransactionsManager.shared.fetchTransactions()
        addTransactions(newTransactions)
    }
    
    /// Fetches new transactions from CoreData
    func fetcthTransactions() {
        let newTransactions = TransactionsManager.shared.fetchTransactions()
        addTransactions(newTransactions)
    }
    
    /// Returns [TransactionGroup] sorted by it's dates
    func getTransactionGroups() -> [TransactionGroup] {
        transactionGroups.values.sorted { $0.date > $1.date }
    }
    
    /// Returns date withous hours, minutes, seconds
    private func dateWithoutTime(_ date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components)!
    }
    
}
