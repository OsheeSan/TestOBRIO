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
            executeMethod()
            return
        }
        
        let currentTime = Date()
        
        if currentTime.timeIntervalSince(lastExecutionTime) >= sessionInterval {
            executeMethod()
        }
    }
    
    private func executeMethod() {
        lastExecutionTime = Date()
        UserDefaults.standard.set(lastExecutionTime, forKey: "lastExecutionTime")
    }
}
