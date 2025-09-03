//
//  AccessibilityMotion.swift
//  AccessibilityLearning
//
//  Created by karan dhiman on 22/08/2025.
//

import UIKit

enum AccessibilityMotion {
    static var isMotionAllowed: Bool {
        return !UIAccessibility.isReduceMotionEnabled
    }
    
    static func safeAnimate(
        with view: UIView,
        withDuration duration: TimeInterval,
        options: UIView.AnimationOptions = [],
        animations: (() -> Void)? = nil,
        completion: ((Bool) -> Void)? = nil
    ) {
        guard isMotionAllowed else {
            animations?()
            completion?(true)
            return
        }
        UIView.transition(
            with: view,
            duration: duration,
            options: options,
            animations: animations,
            completion: completion
        )
    }
}
