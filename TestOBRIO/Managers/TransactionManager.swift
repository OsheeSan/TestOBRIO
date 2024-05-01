//
//  CoreDataManager.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import CoreData
import UIKit

/// Class for interacting with transactions from CoreData
public final class TransactionsManager: NSObject {
    
    public static let shared = TransactionsManager()
    private override init() {}
    
    /// Index of the last loaded transaction
    public var offset = 0
    /// Number of transactions to be loaded at a time
    private let batchSize = 20
    
    private let appDelegate: AppDelegate = {
        UIApplication.shared.delegate as! AppDelegate
    }()
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    /// Create new transaction
    public func createTransaction(amount: Double, date: Date, category: String) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Transaction", in: context) else {
            return
        }
        let transaction = Transaction(entity: entityDescription, insertInto: context)
        transaction.amount = amount
        transaction.date = date
        transaction.category = category
        
        appDelegate.saveContext()
    }
    
    /// Fetch new group of transactions
    public func fetchTransactions() -> [Transaction] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Transaction")
        fetchRequest.fetchOffset = offset
        fetchRequest.fetchLimit = batchSize
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)] 
        
        do {
            let transactions = try context.fetch(fetchRequest) as! [Transaction]
            offset += transactions.count
            return transactions
        } catch {
            print(error.localizedDescription)
        }
        return []
    }

}
