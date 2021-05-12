//
//  GraphDrawer.swift
//  BestCalculator
//
//  Created by talgar osmonov on 11/5/21.
//

import UIKit

struct GraphDrawer {

    var color: UIColor
    var contentScaleFactor: CGFloat  
    
    init(color: UIColor = .black, contentScaleFactor: CGFloat = 1) {
        self.color = color
        self.contentScaleFactor = contentScaleFactor
    }
    
    func drawALine(from: (x: CGFloat?, y: CGFloat?),
                   to: (x: CGFloat, y: CGFloat),
                   in rect: CGRect,
                   origin: CGPoint,
                   pointsPerUnit: CGFloat){
        
        UIGraphicsGetCurrentContext()?.saveGState()
        
        color.set()
        let path = UIBezierPath()
        
        let newX = origin.x + to.x
        let newY = origin.y - to.y
        var oldX: CGFloat?
        var oldY: CGFloat?
        
        if from.x != nil && from.y !=  nil {
            oldX = origin.x + from.x!
            oldY = origin.y - from.y!
        }
        
        if oldX != nil && oldY != nil && !newY.isNaN && !oldY!.isNaN {
            path.move(to: CGPoint(x: oldX!, y: oldY!).aligned(usingScaleFactor: contentScaleFactor)!)
            path.addLine(to: CGPoint(x: newX, y: newY).aligned(usingScaleFactor: contentScaleFactor)!)
            path.lineWidth = 3
            path.stroke()
        }
        
        UIGraphicsGetCurrentContext()?.restoreGState()
    }
}

