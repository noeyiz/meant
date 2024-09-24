//
//  UIFont+.swift
//  meant
//
//  Created by 지연 on 9/24/24.
//

import UIKit

extension UIFont {
    static func nanumSquareNeo(
        ofSize size: CGFloat,
        weight: NanumSquareNeoWeight = .regular
    ) -> UIFont{
        return UIFont(name: weight.fontName, size: size)!
    }
    
    static func nanumMyeongjo(
        ofSize size: CGFloat,
        weight: NanumMyeongjoWeight = .regular
    ) -> UIFont {
        return UIFont(name: weight.fontName, size: size)!
    }
}
