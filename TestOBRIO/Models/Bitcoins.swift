//
//  Bitcoins.swift
//  TestOBRIO
//
//  Created by admin on 01.05.2024.
//

import Foundation
import CoreData

public class Bitcoin: NSManagedObject {

}

extension Bitcoin {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        return NSFetchRequest<Transaction>(entityName: "Bitcoin")
    }

    @NSManaged public var amount: Double

}

extension Bitcoin : Identifiable {

}

