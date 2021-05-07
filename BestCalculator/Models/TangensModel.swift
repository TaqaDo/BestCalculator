//
//  TangensModel.swift
//  BestCalculator
//
//  Created by talgar osmonov on 6/5/21.
//

import Foundation
import UIKit

enum TangensOperation {
    case INV2
    case INV
    case sin
    case cos
    case tan
    case In
    case log
    case palochkiX
    case vosklicX
    case pi
    case e
    case eX
    case koren
    case tenX
    case squareX
    case yX
    case sinMinusOne
    case cosMinus1
    case tanMinus1
    case sinh
    case cosh
    case tanh
    case i
    case sinhMinus1
    case coshMinus1
    case tanhMinus1
    case korenTripl
    case twoX
    case tripleX
    case xMinusY
}

struct TangensModel {
    var title: String!
    var operation: TangensOperation?
    var colorHex: UIColor?

    init(title: String, operation: TangensOperation? = nil, colorHex: UIColor? = nil) {
        self.title = title
        self.operation = operation
        self.colorHex = colorHex
    }
}
