//
//  UILabel+.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import UIKit

extension UILabel {
    func setTextWithLineHeight(_ text: String, lineHeight: CGFloat = 20.0) {
        let attributedString = NSMutableAttributedString(string: text)
        
        // 첫 번째 줄 이후의 텍스트에 대해서만 라인 높이 적용
        if let firstLineRange = text.range(of: "\n") {
            let firstLineEndIndex = text.distance(
                from: text.startIndex,
                to: firstLineRange.lowerBound
            )
            let customLineHeightRange = NSRange(
                location: firstLineEndIndex + 1,
                length: text.count - firstLineEndIndex - 1
            )
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.minimumLineHeight = lineHeight
            paragraphStyle.maximumLineHeight = lineHeight
            
            attributedString.addAttribute(
                .paragraphStyle,
                value: paragraphStyle,
                range: customLineHeightRange
            )
        }
        
        self.attributedText = attributedString
        self.numberOfLines = 0
    }
}
