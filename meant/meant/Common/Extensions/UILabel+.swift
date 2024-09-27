//
//  UILabel+.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import UIKit

extension UILabel {
    func setTextWithLineHeight(_ text: String, lineHeight: CGFloat = 20.0) {
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = lineHeight
        style.maximumLineHeight = lineHeight
        style.alignment = textAlignment
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: style
        ]
        
        let attrString = NSAttributedString(
            string: text,
            attributes: attributes
        )
        
        self.attributedText = attrString
        self.numberOfLines = 0
    }
}
