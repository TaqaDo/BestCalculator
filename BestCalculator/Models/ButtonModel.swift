//
//  File.swift
//  BestCalculator
//
//  Created by talgar osmonov on 4/5/21.
//

import Foundation

enum Type {
    case value
    case operation
}

enum Operation {
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

struct ButtonModel {
    var type: Type!
    var title: String!
    
    var value: Int?
    var operation: Operation?
    
    var colorHex: String?

    init(type: Type, title: String, value: Int? = nil, operation: Operation? = nil, colorHex: String? = nil) {
        self.type = type
        self.title = title
        
        self.value = value
        self.operation = operation
        self.colorHex = colorHex
    }
}
