//
//  Extensions.swift
//  BestCalculator
//
//  Created by talgar osmonov on 4/5/21.
//

import UIKit
import SnapKit

extension Double {
    var roundedToIntIfNeededString: String {
        if floor(self) == self {
            return String(format: "%.0f", self)
        }
        
        return "\(self)"
    }
    
    var factorial: Double {
        if self == 0 {
            return 1
        }
        
        if self.rounded() != self {
            return Double.nan
        }
        
        if self > Double(Int.max) {
            return Double.nan
        }
        
        let value = Int(self)
        var result = NSDecimalNumber(value: 1)
        
        let range: ClosedRange = self < 0 ? (value...(-1)) : (1...value)
        for i in range.reversed() {
            let behavior = NSDecimalNumberHandler.init(roundingMode: .plain, scale: 17, raiseOnExactness: false, raiseOnOverflow: false, raiseOnUnderflow: false, raiseOnDivideByZero: false)
            result = result.multiplying(by: NSDecimalNumber(value: i), withBehavior: behavior)
            
            if result.doubleValue.isNaN {
                return Double.nan
            }
        }
        
        return result.doubleValue
    }
    
    func rounded(to decimalPlaces: Int) -> Double {
        let multiplier = pow(10.0, Double(decimalPlaces))
        return (self * multiplier).rounded() / multiplier
    }
}


struct CalculatorMemory {
    var storage: Dictionary<String, Double>?
}

extension CGPoint {
    
    func distance(to point: CGPoint) -> CGFloat {
        let x = self.x - point.x
        let y = self.y - point.y
        return sqrt(pow(x, 2) + pow(y, 2))
    }
}

extension UICollectionViewCell {
    static var cellID: String {
        return className
    }
}

extension UITableViewCell {
    static var cellID: String {
        return className
    }
}

extension NSObject {
    var className: String {
        return type(of: self).className
    }
    
    static var className: String {
        return String(describing: self)
    }
}

extension UIColor {
    convenience init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    static let darkColor = UIColor.init(hex: "#212129")
    static let mediumDark = UIColor.init(hex: "#2c2c37")
    static let whiterDark = UIColor.init(hex: "#383845")
    static let whiteDark = UIColor.init(hex: "#434353")
}

extension UIView {
    var safeArea: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
    
    var safeAreaEdgesInset: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return self.safeAreaInsets
        } else {
            return UIEdgeInsets()
        }
    }
}

struct GCColor {
    
    static func background(forDarkMode darkMode: Bool) -> UIColor {
        if #available(iOS 13.0, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
   
    static func previewBackground(forDarkMode darkMode: Bool) -> UIColor {
        if darkMode {
            return UIColor(red: 66, green: 66, blue: 66, alpha: 1)
        }
        
        return .white
    }
    
    static func previewOverlay(forDarkMode darkMode: Bool) -> UIColor {
        return UIColor.black.withAlphaComponent(0.25)
    }
    
    static func title(forDarkMode darkMode: Bool) -> UIColor {
        if darkMode {
            return UIColor(red: 237, green: 237, blue: 237, alpha: 1)
        }
        
        return self.highlight(forDarkMode: darkMode)
    }
    
    static func subtitle(forDarkMode darkMode: Bool) -> UIColor {
        if darkMode {
            return self.alternativeKeyText(forDarkMode: darkMode)
        }
        
        return self.alternativeKey(forDarkMode: darkMode)
    }
    
    static func footnote(forDarkMode darkMode: Bool) -> UIColor {
        if darkMode {
            return self.alternativeKey(forDarkMode: darkMode)
        }
        
        return self.key(forDarkMode: darkMode)
    }
    
    static func highlight(forDarkMode darkMode: Bool) -> UIColor {
        if darkMode {
            return UIColor(red: 108, green: 124, blue: 126, alpha: 1)
        }
        
        return UIColor(red: 13, green: 62, blue: 73, alpha: 1)
    }
    
    static func key(forDarkMode darkMode: Bool) -> UIColor {
        if darkMode {
            return UIColor(red: 66, green: 66, blue: 66, alpha: 1)
        }
        
        return UIColor(red: 138, green: 159, blue: 162, alpha: 1)
    }
    
    static func alternativeKey(forDarkMode darkMode: Bool) -> UIColor {
        if darkMode {
            return UIColor(red: 90, green: 90, blue: 90, alpha: 1)
        }
        
        return UIColor(red: 100, green: 133, blue: 140, alpha: 1)
    }
    
    static func keyBorder(forDarkMode darkMode: Bool) -> UIColor {
        if darkMode {
            return UIColor(red: 118, green: 118, blue: 118, alpha: 1)
        }
        
        return .white
    }
    
    static func popoverBorder(forDarkMode darkMode: Bool) -> UIColor {
        if darkMode {
            return UIColor(red: 190, green: 190, blue: 190, alpha: 1)
        }
        
        return .white
    }
    
    static func alternativeKeyText(forDarkMode darkMode: Bool) -> UIColor {
        if darkMode {
            return UIColor(red: 124, green: 124, blue: 124, alpha: 1)
        }
        
        return self.alternativeKey(forDarkMode: darkMode)
    }
    
    static func graph(forDarkMode darkMode: Bool) -> UIColor {
        if darkMode {
            return UIColor.green
        }
        
        return UIColor.green
    }
}

