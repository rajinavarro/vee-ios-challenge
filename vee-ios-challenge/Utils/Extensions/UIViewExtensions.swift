//
//  UIViewExtensions.swift
//  vee-ios-challenge
//
//  Created by raji navarro on 11/12/20.
//

import Foundation
import UIKit

extension UIView {
    
    func addShadow(color: UIColor, opacity: Float, offset: CGSize = .zero, radius: CGFloat){
        
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
    
    func roundCorners(_ corners:UIRectCorner, radius: CGFloat) {
        
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        
        self.layer.mask = mask
    }
    
}
