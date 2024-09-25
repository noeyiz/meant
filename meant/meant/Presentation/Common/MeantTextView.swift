//
//  MeantTextView.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import UIKit

class MeantTextView: UITextView {
    var lineHeightMultiple: CGFloat = 2.0 {
        didSet {
            updateTextStyle()
        }
    }
    
    // MARK: - Init
    
    init() {
        super.init(frame: .zero, textContainer: nil)
        
        font = .nanumSquareNeo(ofSize: 12.0)
        textColor = .gray03
        backgroundColor = .clear
        autocorrectionType = .no
        autocapitalizationType = .none
        layoutManager.allowsNonContiguousLayout = false
        
        updateTextStyle()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Appearance
    
    private func updateTextStyle() {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle,
            .font: font ?? .systemFont(ofSize: 12.0),
            .foregroundColor: textColor ?? .black
        ]
        
        typingAttributes = attributes
        
        if let existingText = text, !existingText.isEmpty {
            let attributedString = NSAttributedString(string: existingText, attributes: attributes)
            attributedText = attributedString
        }
    }
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        var originalRect = super.caretRect(for: position)
        
        if let font = self.font {
            let caretHeight = font.lineHeight * 1.2
            let caretY = originalRect.origin.y + originalRect.height - caretHeight
            originalRect.origin.y = caretY
            originalRect.size.height = caretHeight
        }
        
        return originalRect
    }
}
