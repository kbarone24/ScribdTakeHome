//
//  HapticGenerator.swift
//  Scribd Take Home
//
//  Created by Kenny Barone on 3/5/24.
//

import UIKit

class HapticGenerator {
    static let shared = HapticGenerator()

    private init() { }

    func play(_ feedbackStyle: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: feedbackStyle).impactOccurred()
    }

    func notify(_ feedbackType: UINotificationFeedbackGenerator.FeedbackType) {
        UINotificationFeedbackGenerator().notificationOccurred(feedbackType)
    }
}

