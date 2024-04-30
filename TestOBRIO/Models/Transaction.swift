//
//  Transaction.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import Foundation

struct Transaction {
    let date: Date
    let amount: Double
    let category: String
}

struct TransactionGroup {
    var date: Date
    var transactions: [Transaction]
}


class TransactionTestDataSource {
    static var transactions: [Transaction] = [
        Transaction(date: Date(), amount: 0.5, category: "groceries"),
        Transaction(date: Calendar.current.date(byAdding: .day, value: -2, to: Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: Date())!)!, amount: -10.0, category: "taxi"),
        Transaction(date: Date(), amount: 20.0, category: "electronics"),
        Transaction(date: Date(), amount: 30.0, category: "restaurant"),
        Transaction(date: Date(), amount: 40.0, category: "other"),
    ]
}
