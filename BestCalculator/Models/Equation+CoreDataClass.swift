//
//  Equation+CoreDataClass.swift
//  
//
//  Created by talgar osmonov on 17/5/21.
//
//

import Foundation
import CoreData


public class Equation: NSManagedObject {

}

extension Equation {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Equation> {
        return NSFetchRequest<Equation>(entityName: "Equation")
    }

    @NSManaged public var inputResult: String?
    @NSManaged public var outputResult: String?

}
