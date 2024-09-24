//
//  UIView+.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import UIKit

extension UIView{
    func setGradient(color1: UIColor,color2: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [color1.cgColor,color2.cgColor]
        gradientLayer.locations = [0.0 , 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
}

