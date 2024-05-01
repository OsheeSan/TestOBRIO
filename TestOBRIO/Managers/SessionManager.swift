//
//  SessionManager.swift
//  TestOBRIO
//
//  Created by admin on 01.05.2024.
//

import Foundation

class SessionManager {
    static let shared = SessionManager()
    
    private let sessionInterval: TimeInterval = 3600
    private var lastExecutionTime: Date?
    
    private init() {
        lastExecutionTime = UserDefaults.standard.value(forKey: "lastExecutionTime") as? Date
    }
    
    func executeIfNeeded() {
        guard let lastExecutionTime = lastExecutionTime else {
            executeMethod(updated: true)
            print("Need")
            return
        }
        
        let currentTime = Date()
        
        if currentTime.timeIntervalSince(lastExecutionTime) >= sessionInterval {
            executeMethod(updated: true)
            print("Need")
        } else {
            executeMethod(updated: false)
        }
    }
    
    private func executeMethod(updated: Bool) {
        if updated {
            NetworkManager.getBitcoinInDollars(completion: {
                exchange in
                BalanceManager.shared.setExchange(exchange)
            })
            lastExecutionTime = Date()
            UserDefaults.standard.set(lastExecutionTime, forKey: "lastExecutionTime")
        } else {
            BalanceManager.shared.setExchange(BitcoinManager.shared.getBitcoinExchange())
        }
    }
}
