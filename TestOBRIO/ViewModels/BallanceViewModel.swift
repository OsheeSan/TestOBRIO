//
//  BallanceViewModel.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import Foundation

class BallanceViewModel {
    
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
    
    func getTransactionGroups() -> [TransactionGroup] {
        transactionGroups.values.sorted { $0.date > $1.date }
    }
    
    private func dateWithoutTime(_ date: Date) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        return calendar.date(from: components)!
    }
    
}