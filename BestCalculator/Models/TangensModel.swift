//
//  TangensModel.swift
//  BestCalculator
//
//  Created by talgar osmonov on 6/5/21.
//

import Foundation


enum TangensOperation {
    case multiplication
    case division
    case deduction
    case addition
    case percent
    
    case comma
    case clean
    case braces
    
    case systemCoordinate
    
    case result
}

struct TangensModel {
    var title: String!
    var operation: TangensOperation?
    var colorHex: String?

    init(type: Type, title: String, operation: TangensOperation? = nil, colorHex: String? = nil) {
        self.title = title
        self.operation = operation
        self.colorHex = colorHex
    }
}
