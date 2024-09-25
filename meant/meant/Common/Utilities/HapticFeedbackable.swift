//
//  HapticFeedbackable.swift
//  meant
//
//  Created by 지연 on 9/25/24.
//

import UIKit

protocol HapticFeedbackable {
    func generateHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle)
}

extension HapticFeedbackable {
    func generateHaptic(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
