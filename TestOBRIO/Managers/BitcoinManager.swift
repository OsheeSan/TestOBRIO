//
//  BitcoinManager.swift
//  TestOBRIO
//
//  Created by admin on 01.05.2024.
//

import UIKit
import CoreData

class BitcoinManager {
    
    public static let shared = BitcoinManager()
    
    private let appDelegate: AppDelegate = {
        UIApplication.shared.delegate as! AppDelegate
    }()
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
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
            print(error.localizedDescription)
        }
        if data == nil {
            data = Bitcoin(context: context)
        }
        data?.amount = (data?.amount ?? 0) + value
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
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
            print(error.localizedDescription)
        }
        if data == nil {
            data = Bitcoin(context: context)
        }
        data!.amount = data!.amount - value
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getBitcoinValue() -> Double {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bitcoin")
        do {
            let results = try context.fetch(fetchRequest)
            if let existingData = results.first {
                let data = existingData as! Bitcoin
                return data.amount
            }
        } catch {
            print(error.localizedDescription)
        }
        return 0
    }
    
    func getBitcoinExchange() -> Double {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bitcoin")
        do {
            let results = try context.fetch(fetchRequest)
            if let existingData = results.first {
                let data = existingData as! Bitcoin
                return data.exchange
            }
        } catch {
            print(error.localizedDescription)
        }
        return 0
    }
    
    func setBitcoinExchange(_ value: Double) {
        var data: Bitcoin?
        do {
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Bitcoin")
            let results = try context.fetch(fetchRequest)
            if let existingData = results.first {
                data = existingData as? Bitcoin
            }
        } catch {
            print(error.localizedDescription)
        }
        if data == nil {
            data = Bitcoin(context: context)
        }
        data?.exchange = value
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}
