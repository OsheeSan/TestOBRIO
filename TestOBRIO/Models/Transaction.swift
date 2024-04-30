//
//  Transaction.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import Foundation
import CoreData

public class Transaction: NSManagedObject {

}

extension Transaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Transaction")
    }

    @NSManaged public var date: Date
    @NSManaged public var amount: Double
    @NSManaged public var category: String

}

extension Transaction : Identifiable {

}

struct TransactionGroup {
    var date: Date
    var transactions: [Transaction]
}
