//
//  CoreDataManager.swift
//  TestOBRIO
//
//  Created by admin on 30.04.2024.
//

import CoreData
import UIKit


public final class CoreDataManager: NSObject {
    
    public static let shared = CoreDataManager()
    private override init() {}
    
    public var offset = 0
    private let batchSize = 20
    
    private let appDelegate: AppDelegate = {
        UIApplication.shared.delegate as! AppDelegate
    }()
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
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
    
    func addBitcoins(_ value: Double) {
            var data: Bitcoin?
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bitcoin")
                let results = try context.fetch(fetchRequest)
                if let existingData = results.first {
                    data = existingData as? Bitcoin
                }
            } catch {
                print("Ошибка запроса данных: \(error)")
            }
            if data == nil {
                data = Bitcoin(context: context)
            }
            data?.amount = (data?.amount ?? 0) + value
            do {
                try context.save()
            } catch {
                print("Ошибка сохранения данных: \(error)")
            }
        }
    
    func takeBitcoins(_ value: Double) {
            var data: Bitcoin?
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bitcoin")
                let results = try context.fetch(fetchRequest)
                if let existingData = results.first {
                    data = existingData as? Bitcoin
                }
            } catch {
                print("Ошибка запроса данных: \(error)")
            }
            if data == nil {
                data = Bitcoin(context: context)
            }
            data!.amount = data!.amount - value
            do {
                try context.save()
            } catch {
                print("Ошибка сохранения данных: \(error)")
            }
        }
        
        func getBitcoinValue() -> Double {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bitcoin")
            do {
                let results = try context.fetch(fetchRequest)
                if let existingData = results.first {
                    var data = existingData as! Bitcoin
                    return data.amount
                }
            } catch {
                print("Ошибка запроса данных: \(error)")
            }
            
            return 0
        }

    
}
